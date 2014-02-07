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

class Usergameanalytics
  include Mongoid::Document
  field :lastlogin, type: DateTime
  field :uid, type: Integer
  field :extid, type: String
  field :nwin, type: Integer, :default=>0
  field :nlost, type: Integer, :default=>0
  field :nlogin, type: Integer, :default=>0
  field :ndisconnect, type: Integer, :default=>0
  field :nfriend, type: Integer, :default=>0
  field :purchase, type: String
  
  # This method is to create analytics record for the user
  def self.createUserAnalyticsRecord(extid)
    #get the user details from user table
     usr = User.find_by_externalid(extid)
     Usergameanalytics.create([{lastlogin: Time.current, uid: usr.id, extid:extid}])
     uga = Usergameanalytics.find_by(uid:usr.id)
     return uga
  end
  
  #this is to update the number of time she logged in to the system 
  #similarly we can update the other records whenever he/she wins or looses the match
  def self.updateNumberOfLogins(extid)
    ugas = Usergameanalytics.find_by(extid:extid)
    @numgames = ugas.nlogin+1
    ugas.update_attribute(:nlogin,@numgames)
    
    return ugas
  end
  
  def self.updateUserGameAnalytics(uid)
    
  end
  # this is to update the user's purchase record 
  def self.updatePurchase()
    
  end
end