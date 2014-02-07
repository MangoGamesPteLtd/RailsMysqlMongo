=begin
/*******************************************************************************

Copyright (c) 2013 Mango Games Interactive Pte Ltd

 

Permission is hereby granted, free of charge, to any person obtaining a copy

of this software and associated documentation files (the "Software"), to deal

in the Software without restriction, including without limitation the rights

to use, copy, modify, merge, publish, distribute, sublicense, and/or sell

copies of the Software, and to permit persons to whom the Software is

furnished to do so, subject to the following conditions:

 

The above copyright notice and this permission notice shall be included in

all copies or substantial portions of the Software.

*******************************************************************************/ 
=end
class User < ActiveRecord::Base
  self.table_name="user"
  
  def self.createUser(extid, name, gender)
    # create new row in the user table and update the fields 
      usr = User.new
      usr.externalid = extid
      usr.name=name
      usr.gender = gender
      begin 
         usr.save
      rescue
         usr = nil
      end
      # return the user object
      return usr
  end
  
  def self.findOrCreateUserByExternalId(extid, name, gender)
    
    usr = User.find_by_externalid(extid)
    if(usr==nil)
      usr = User.createUser(extid, name, gender)
    end
    return usr
  end
end
