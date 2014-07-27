// AFOAuth2Client.m
//
// Copyright (c) 2012 Mattt Thompson (http://mattt.me/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "AFJSONRequestOperation.h"

#import "AFOAuth2Client.h"

NSString * const kAFOAuthCodeGrantType = @"authorization_code";
NSString * const kAFOAuthClientCredentialsGrantType = @"client_credentials";
NSString * const kAFOAuthPasswordCredentialsGrantType = @"password";
NSString * const kAFOAuthRefreshGrantType = @"refresh_token";

#ifdef _SECURITY_SECITEM_H_
NSString * const kAFOAuthCredentialServiceName = @"AFOAuthCredentialService";

static NSMutableDictionary * AFKeychainQueryDictionaryWithIdentifier(NSString *identifier) {
    NSMutableDictionary *queryDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:(__bridge id)kSecClassGenericPassword, kSecClass, kAFOAuthCredentialServiceName, kSecAttrService, nil];
    [queryDictionary setValue:identifier forKey:(__bridge id)kSecAttrAccount];

    return queryDictionary;
}
#endif

#pragma mark -

@interface AFOAuth2Client ()
@property (readwrite, nonatomic) NSString *serviceProviderIdentifier;
@property (readwrite, nonatomic) NSString *clientID;
@property (readwrite, nonatomic) NSString *secret;
@end

@implementation AFOAuth2Client

+ (instancetype)clientWithBaseURL:(NSURL *)url
                         clientID:(NSString *)clientID
                           secret:(NSString *)secret
{
    return [[self alloc] initWithBaseURL:url clientID:clientID secret:secret];
}

- (id)initWithBaseURL:(NSURL *)url
             clientID:(NSString *)clientID
               secret:(NSString *)secret
{
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }

    self.serviceProviderIdentifier = [self.baseURL host];
    self.clientID = clientID;
    self.secret = secret;

    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];

    return self;
}

#pragma mark -

- (void)setAuthorizationHeaderWithToken:(NSString *)token {
    // Use the "Bearer" type as an arbitrary default
    [self setAuthorizationHeaderWithToken:token ofType:@"Bearer"];
}

- (void)setAuthorizationHeaderWithCredential:(AFOAuthCredential *)credential {
    [self setAuthorizationHeaderWithToken:credential.accessToken ofType:credential.tokenType];
}

- (void)setAuthorizationHeaderWithToken:(NSString *)token
                                 ofType:(NSString *)type
{
    // http://tools.ietf.org/html/rfc6749#section-7.1
    // The Bearer type is the only finalized type
    if ([[type lowercaseString] isEqualToString:@"bearer"]) {
        [self setDefaultHeader:@"Authorization" value:[NSString stringWithFormat:@"Bearer %@", token]];
    }
}

#pragma mark -

- (void)authenticateUsingOAuthWithPath:(NSString *)path
                                  code:(NSString *)code
                           redirectURI:(NSString *)uri
                               success:(void (^)(AFOAuthCredential *credential))success
                               failure:(void (^)(NSError *error))failure
{
    NSMutableDictionary *mutableParameters = [NSMutableDictionary dictionary];
    [mutableParameters setObject:kAFOAuthCodeGrantType forKey:@"grant_type"];
    [mutableParameters setValue:code forKey:@"code"];
    [mutableParameters setValue:uri forKey:@"redirect_uri"];
    NSDictionary *parameters = [NSDictionary dictionaryWithDictionary:mutableParameters];

    [self authenticateUsingOAuthWithPath:path parameters:parameters success:success failure:failure];
}

- (void)authenticateUsingOAuthWithPath:(NSString *)path
                              username:(NSString *)username
                              password:(NSString *)password
                                 scope:(NSString *)scope
                               success:(void (^)(AFOAuthCredential *credential))success
                               failure:(void (^)(NSError *error))failure
{
    NSMutableDictionary *mutableParameters = [NSMutableDictionary dictionary];
    [mutableParameters setObject:kAFOAuthPasswordCredentialsGrantType forKey:@"grant_type"];
    //[mutableParameters setValue:username forKey:@"username"];
    //[mutableParameters setValue:password forKey:@"password"];
    [self clearAuthorizationHeader];
    [self setAuthorizationHeaderWithUsername:username password:password];
    [mutableParameters setValue:scope forKey:@"scope"];
    NSDictionary *parameters = [NSDictionary dictionaryWithDictionary:mutableParameters];

    [self authenticateUsingOAuthWithPath:path parameters:parameters success:success failure:failure];
}

- (void)authenticateUsingOAuthWithPath:(NSString *)path
                                 scope:(NSString *)scope
                               success:(void (^)(AFOAuthCredential *credential))success
                               failure:(void (^)(NSError *error))failure
{
    NSMutableDictionary *mutableParameters = [NSMutableDictionary dictionary];
    [mutableParameters setObject:kAFOAuthClientCredentialsGrantType forKey:@"grant_type"];
    [mutableParameters setValue:scope forKey:@"scope"];
    NSDictionary *parameters = [NSDictionary dictionaryWithDictionary:mutableParameters];

    [self authenticateUsingOAuthWithPath:path parameters:parameters success:success failure:failure];
}

- (void)authenticateUsingOAuthWithPath:(NSString *)path
                          refreshToken:(NSString *)refreshToken
                               success:(void (^)(AFOAuthCredential *credential))success
                               failure:(void (^)(NSError *error))failure
{
    NSMutableDictionary *mutableParameters = [NSMutableDictionary dictionary];
    [mutableParameters setObject:kAFOAuthRefreshGrantType forKey:@"grant_type"];
    [mutableParameters setValue:refreshToken forKey:@"refresh_token"];
    NSDictionary *parameters = [NSDictionary dictionaryWithDictionary:mutableParameters];

    [self authenticateUsingOAuthWithPath:path parameters:parameters success:success failure:failure];
}

- (void)authenticateUsingOAuthWithPath:(NSString *)path
                            parameters:(NSDictionary *)parameters
                               success:(void (^)(AFOAuthCredential *credential))success
                               failure:(void (^)(NSError *error))failure
{
    NSMutableDictionary *mutableParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [mutableParameters setObject:self.clientID forKey:@"client_id"];
    [mutableParameters setObject:self.secret forKey:@"client_secret"];
    parameters = [NSDictionary dictionaryWithDictionary:mutableParameters];

//    [self clearAuthorizationHeader];
//    [self setAuthorizationHeaderWithUsername:@"appgame" password:@"kiueo_0903xerw3"];//kiueo_0903xerw3
    NSMutableURLRequest *mutableRequest = [self requestWithMethod:@"POST" path:path parameters:parameters];
    [mutableRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];

    AFHTTPRequestOperation *authOperation = [self HTTPRequestOperationWithRequest:mutableRequest success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject valueForKey:@"error"]) {
            if (failure) {
                // TODO: Resolve the `error` field into a proper NSError object
                // http://tools.ietf.org/html/rfc6749#section-5.2
                failure(nil);
            }

            return;
        }

        NSString *refreshToken = [responseObject valueForKey:@"refresh_token"];
        refreshToken = refreshToken ? refreshToken : [parameters valueForKey:@"refresh_token"];

        AFOAuthCredential *credential = [AFOAuthCredential credentialWithOAuthToken:[responseObject valueForKey:@"access_token"] tokenType:[responseObject valueForKey:@"token_type"] username:[responseObject valueForKey:@"username"] user_id:[responseObject valueForKey:@"user_id"]];
        [credential setRefreshToken:refreshToken expiration:[NSDate dateWithTimeIntervalSinceNow:[[responseObject valueForKey:@"expires_in"] integerValue]]];

        [self setAuthorizationHeaderWithCredential:credential];

        if (success) {
            success(credential);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

    [self enqueueHTTPRequestOperation:authOperation];
}

@end

#pragma mark -

@interface AFOAuthCredential ()
@property (readwrite, nonatomic) NSString *accessToken;
@property (readwrite, nonatomic) NSString *tokenType;
@property (readwrite, nonatomic) NSString *refreshToken;
@property (readwrite, nonatomic) NSDate *expiration;
@property (readwrite, nonatomic) NSString *username;
@property (readwrite, nonatomic) NSString *user_id;
@end

@implementation AFOAuthCredential
@synthesize accessToken = _accessToken;
@synthesize tokenType = _tokenType;
@synthesize refreshToken = _refreshToken;
@synthesize expiration = _expiration;
@synthesize username = _username;
@synthesize user_id = _user_id;

@dynamic expired;

#pragma mark -

+ (instancetype)credentialWithOAuthToken:(NSString *)token
                               tokenType:(NSString *)type
                                username:(NSString *)name
                                 user_id:(NSString *)userId
{
    return [[self alloc] initWithOAuthToken:token tokenType:type username:name user_id:userId];
}

- (id)initWithOAuthToken:(NSString *)token
               tokenType:(NSString *)type
                username:(NSString *)name
                 user_id:(NSString *)userId
{
    self = [super init];
    if (!self) {
        return nil;
    }

    self.accessToken = token;
    self.tokenType = type;
    self.username = name;
    self.user_id = userId;

    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@ accessToken:\"%@\" tokenType:\"%@\" refreshToken:\"%@\" expiration:\"%@\">", [self class], self.accessToken, self.tokenType, self.refreshToken, self.expiration];
}

- (void)setRefreshToken:(NSString *)refreshToken
             expiration:(NSDate *)expiration
{
    if (!refreshToken || !expiration) {
        return;
    }

    self.refreshToken = refreshToken;
    self.expiration = expiration;
}

- (BOOL)isExpired {
    return [self.expiration compare:[NSDate date]] == NSOrderedAscending;
}

#pragma mark Keychain

#ifdef _SECURITY_SECITEM_H_

+ (BOOL)storeCredential:(AFOAuthCredential *)credential
         withIdentifier:(NSString *)identifier
{
    NSMutableDictionary *queryDictionary = AFKeychainQueryDictionaryWithIdentifier(identifier);

    if (!credential) {
        return [self deleteCredentialWithIdentifier:identifier];
    }

    NSMutableDictionary *updateDictionary = [NSMutableDictionary dictionary];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:credential];
    [updateDictionary setObject:data forKey:(__bridge id)kSecValueData];

    OSStatus status;
    BOOL exists = ([self retrieveCredentialWithIdentifier:identifier] != nil);

    if (exists) {
        status = SecItemUpdate((__bridge CFDictionaryRef)queryDictionary, (__bridge CFDictionaryRef)updateDictionary);
    } else {
        [queryDictionary addEntriesFromDictionary:updateDictionary];
        status = SecItemAdd((__bridge CFDictionaryRef)queryDictionary, NULL);
    }

    if (status != errSecSuccess) {
        NSLog(@"Unable to %@ credential with identifier \"%@\" (Error %li)", exists ? @"update" : @"add", identifier, status);
    }

    return (status == errSecSuccess);
}

+ (BOOL)deleteCredentialWithIdentifier:(NSString *)identifier {
    NSMutableDictionary *queryDictionary = AFKeychainQueryDictionaryWithIdentifier(identifier);

    OSStatus status = SecItemDelete((__bridge CFDictionaryRef)queryDictionary);

    if (status != errSecSuccess) {
        NSLog(@"Unable to delete credential with identifier \"%@\" (Error %li)", identifier, status);
    }

    return (status == errSecSuccess);
}

+ (AFOAuthCredential *)retrieveCredentialWithIdentifier:(NSString *)identifier {
    NSMutableDictionary *queryDictionary = AFKeychainQueryDictionaryWithIdentifier(identifier);
    [queryDictionary setObject:(__bridge id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    [queryDictionary setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];

    CFDataRef result = nil;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)queryDictionary, (CFTypeRef *)&result);

    if (status != errSecSuccess) {
        NSLog(@"Unable to fetch credential with identifier \"%@\" (Error %li)", identifier, status);
        return nil;
    }

    NSData *data = (__bridge NSData *)result;
    AFOAuthCredential *credential = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    return credential;
}

#endif

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    self.accessToken = [decoder decodeObjectForKey:@"accessToken"];
    self.tokenType = [decoder decodeObjectForKey:@"tokenType"];
    self.refreshToken = [decoder decodeObjectForKey:@"refreshToken"];
    self.expiration = [decoder decodeObjectForKey:@"expiration"];
    self.username = [decoder decodeObjectForKey:@"username"];
    self.user_id = [decoder decodeObjectForKey:@"user_id"];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.accessToken forKey:@"accessToken"];
    [encoder encodeObject:self.tokenType forKey:@"tokenType"];
    [encoder encodeObject:self.refreshToken forKey:@"refreshToken"];
    [encoder encodeObject:self.expiration forKey:@"expiration"];
    [encoder encodeObject:self.username forKey:@"username"];
    [encoder encodeObject:self.user_id forKey:@"user_id"];
}

@end
