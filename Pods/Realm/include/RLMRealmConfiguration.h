////////////////////////////////////////////////////////////////////////////
//
// Copyright 2015 Realm Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
////////////////////////////////////////////////////////////////////////////

#import <Foundation/Foundation.h>
#import <Realm/RLMRealm.h>

NS_ASSUME_NONNULL_BEGIN

/**
 A block called when opening a Realm for the first time during the life
 of a process to determine if it should be compacted before being returned
 to the user. It is passed the total file size (data + free space) and the total
 bytes used by data in the file.

 Return `YES` to indicate that an attempt to compact the file should be made.
 The compaction will be skipped if another process is accessing it.
 */
typedef BOOL (^RLMShouldCompactOnLaunchBlock)(NSUInteger totalBytes, NSUInteger bytesUsed);

/**
 An `RLMRealmConfiguration` instance describes the different options used to
 create an instance of a Realm.

 `RLMRealmConfiguration` instances are just plain `NSObject`s. Unlike `RLMRealm`s
 and `RLMObject`s, they can be freely shared between threads as long as you do not
 mutate them.

 Creating configuration objects for class subsets (by setting the
 `objectClasses` property) can be expensive. Because of this, you will normally want to
 cache and reuse a single configuration object for each distinct configuration rather than
 creating a new object each time you open a Realm.
 */
@interface RLMRealmConfiguration : NSObject<NSCopying>

#pragma mark - Default Configuration

/**
 Returns the default configuration used to create Realms when no other
 configuration is explicitly specified (i.e. `+[RLMRealm defaultRealm]`).

 @return The default Realm configuration.
 */
+ (instancetype)defaultConfiguration;

/**
 Sets the default configuration to the given `RLMRealmConfiguration`.

 @param configuration The new default Realm configuration.
 */
+ (void)setDefaultConfiguration:(RLMRealmConfiguration *)configuration;

#pragma mark - Properties

/// The local URL of the Realm file. Mutually exclusive with `inMemoryIdentifier`;
/// setting one of the two properties will automatically nil out the other.
@property (nonatomic, copy, nullable) NSURL *fileURL;

/// A string used to identify a particular in-memory Realm. Mutually exclusive with `fileURL` and `syncConfiguration`;
/// setting any one of the three properties will automatically nil out the other two.
@property (nonatomic, copy, nullable) NSString *inMemoryIdentifier;

/// A 64-byte key to use to encrypt the data, or `nil` if encryption is not enabled.
@property (nonatomic, copy, nullable) NSData *encryptionKey;

/// Whether to open the Realm in read-only mode.
///
/// This is required to be able to open Realm files which are not writeable or
/// are in a directory which is not writeable. This should only be used on files
/// which will not be modified by anyone while they are open, and not just to
/// get a read-only view of a file which may be written to by another thread or
/// process. Opening in read-only mode requires disabling Realm's reader/writer
/// coordination, so committing a write transaction from another process will
/// result in crashes.
@property (nonatomic) BOOL readOnly;

/// The current schema version.
@property (nonatomic) uint64_t schemaVersion;

/// The block which migrates the Realm to the current version.
@property (nonatomic, copy, nullable) RLMMigrationBlock migrationBlock;

/**
 Whether to recreate the Realm file with the provided schema if a migration is required.
 This is the case when the stored schema differs from the provided schema or
 the stored schema version differs from the version on this configuration.
 Setting this property to `YES` deletes the file if a migration would otherwise be required or executed.

 @note Setting this property to `YES` doesn't disable file format migrations.
 */
@property (nonatomic) BOOL deleteRealmIfMigrationNeeded;

/**
 A block called when opening a Realm for the first time during the life
 of a process to determine if it should be compacted before being returned
 to the user. It is passed the total file size (data + free space) and the total
 bytes used by data in the file.

 Return `YES` to indicate that an attempt to compact the file should be made.
 The compaction will be skipped if another process is accessing it.
 */
@property (nonatomic, copy, nullable) RLMShouldCompactOnLaunchBlock shouldCompactOnLaunch;

/// The classes managed by the Realm.
@property (nonatomic, copy, nullable) NSArray *objectClasses;

/**
 The maximum number of live versions in the Realm file before an exception will
 be thrown when attempting to start a write transaction.

 Realm provides MVCC snapshot isolation, meaning that writes on one thread do
 not overwrite data being read on another thread, and instead write a new copy
 of that data. When a Realm refreshes it updates to the latest version of the
 data and releases the old versions, allowing them to be overwritten by
 subsequent write transactions.

 Under normal circumstances this is not a problem, but if the number of active
 versions grow too large, it will have a negative effect on the filesize on
 disk. This can happen when performing writes on many different threads at
 once, when holding on to frozen objects for an extended time, or when
 performing long operations on background threads which do not allow the Realm
 to refresh.

 Setting this property to a non-zero value makes it so that exceeding the set
 number of versions will instead throw an exception. This can be used with a
 low value during development to help identify places that may be problematic,
 or in production use to cause the app to crash rather than produce a Realm
 file which is too large to be oened.

 */
@property (nonatomic) NSUInteger maximumNumberOfActiveVersions;

@end

NS_ASSUME_NONNULL_END
