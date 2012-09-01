Mram::PhpbbHash
===============

i'm not exactly sure what, and why, the phpBB people are doing this crazy custom hashing. but if you ever need to authenticate against a phpBB user table, this gem will help you do exactly that.

Usage
-----

just include mram-phpbb\_hash in your Gemfile, and use it like this:

    inputpass = params[:password] # from post variables, for example
    phpbbhash = get_hash_from_phpbb_database(params[:user]) # whatever you need to do to get the hash from the database
    if Mram::PhpbbHash.check_hash(inputpass, phpbbhash) then
      puts "success!"
    else
      puts "hash does not match!"
    end

Other Info
----------

the actual code was translated to ruby by me from [phpBB 3 Sources](https://github.com/phpbb/phpbb3/blob/develop/phpBB/includes/functions.php).
appearently, there was no other gem doing this so far..
