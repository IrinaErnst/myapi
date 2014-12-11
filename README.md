*****************************************************************************************
                                     Place-it
*****************************************************************************************

Server: Heroku
API: Sinatra
Language: Ruby
Database: Redis/Redis Cloud

The app is currently running at: 
http://frozen-shelf-4349.herokuapp.com/.herokuapp.com, and uses Redis Cloud as a backend.

*****************************************************************************************
                                      Heroku 
*****************************************************************************************

Run the server: foreman start

*****************************************************************************************
                                    Redis Cloud
*****************************************************************************************
To access Redis Cloud Dashboard run:
heroku addons:open rediscloud

SET and GET a key, get your db INFO and FLUSH the db.

SET key value [EX seconds] [PX milliseconds] [NX|XX]
Set key to hold the string value. If key already holds a value, it is overwritten, 
regardless of its type. Any previous time to live associated with the key is discarded 
on successful SET operation.

EX seconds -- Set the specified expire time, in seconds.
PX milliseconds -- Set the specified expire time, in milliseconds.
NX -- Only set the key if it does not already exist.
XX -- Only set the key if it already exist.
Note: Since the SET command options can replace SETNX, SETEX, PSETEX, it is possible 
that in future versions of Redis these three commands will be deprecated and finally 
removed.

Example:
redis> SET mykey "Hello"
OK
redis> GET mykey
"Hello"
redis> 


INFO [section]
The INFO command returns information and statistics about the server in a format that 
is simple to parse by computers and easy to read by humans.
The optional parameter can be used to select a specific section of information:
server: General information about the Redis server
clients: Client connections section
memory: Memory consumption related information
persistence: RDB and AOF related information
stats: General statistics
replication: Master/slave replication information
cpu: CPU consumption statistics
commandstats: Redis command statistics
cluster: Redis Cluster section
keyspace: Database related statistics
It can also take the following values:
all: Return all sections
default: Return only the default set of sections
When no parameter is provided, the default option is assumed.

Return value: Bulk string reply: as a collection of text lines.
Lines can contain a section name (starting with a # character) or a property. All the 
properties are in the form of field:value terminated by \r\n.

redis> INFO


FLUSHDB
Delete all the keys of the currently selected DB. This command never fails.
The time-complexity for this operation is O(N), N being the number of keys in the database.
Return value: Simple string reply