# Nexus Repository Migrator

## Features

In release 3.71.0, Sonatype Nexus Repository began using H2 as its default embedded database.
OrientDB is now in Extended Maintenance as defined in our [Sunsetting documentation](https://help.sonatype.com/en/sonatype-sunsetting-information.html).
Those wishing to upgrade to version 3.71.0 or above will need to migrate to either an H2 or PostgreSQL database.
See our detailed [help topic on Upgrading to 3.71.0 and beyond](https://help.sonatype.com/en/upgrading-to-nexus-repository-3-71-0-and-beyond.html).

This package contains the migrator tool to migrate a Sonatype Nexus Repository 3.70.1 database from OrientDb to H2 (available to all) or PostgreSQL (available to Pro license holders).

You can either install the package and run the migrator by following the instructions in Notes, or run the script `ConvertFrom-NexusOrientDb` in the tools directory.

If you have upgraded to the `nexus-repository` package version 3.71.0.6 and your installation is failing to run, you can run the `Repair-Nexus371FailedUpgrade` script in the tools directory.

## Package Parameters

This package supports the following parameters:

* `/Migrate` - Triggers migration of your existing Sonatype Nexus install(s) from OrientDb to a H2 database.
* `/FQDN` - The fully-qualified domain name that matches the subject you are using for your Nexus instance SSL certificate.

You can pass parameters as follows:

`choco install nexus-repository-migrator --parameters="/Migrate /FQDN=nexus.example.com"`

## Notes

**Please note that using the scripts contained within is entirely at the user's own risk. Read them before you run them!**

For more details, including how to migrate to PostgreSQL, see the [Migrating To A New Database article](https://help.sonatype.com/en/migrating-to-a-new-database.html).

### Migration Environment Prerequisite Requirements

The checklist below covers requirements for a successful database migration:

- If you are migrating from OrientDB to H2 or PostgreSQL, your OrientDB-based instance must be on the latest 3.70.x version.
- You must have JRE 8 or JRE 11 available. The Chocolatey `nexus-repository` 3.70.1.6 package contains this already.
- You must have at least 16GB RAM available.
- You must have a database backup in a clean working location.
- The migrator utility requires three times the disk space (minimum 10 GB) as your $data-dir/db directory.

### Migrating From OrientDB to H2

1. Perform a full backup using normal backup procedures.
1. Copy the backup to a clean working location on a different filesystem so that any extraction doesn’t impact the existing production system.
1. Shut down Nexus Repository.
1. Run the following command from the clean working location containing your database backup. You may include any of the optional parameters listed in the section below when running this command.
    `java -Xmx16G -Xms16G -XX:+UseG1GC -XX:MaxDirectMemorySize=28672M -jar nexus-db-migrator-*.jar --migration_type=h2`
1. Copy the resultant nexus.mv.db file to your $data-dir/db directory.
1. Edit the $data-dir/etc/nexus.properties file and add the following line: `nexus.datastore.enabled=true`
1. Start Nexus Repository