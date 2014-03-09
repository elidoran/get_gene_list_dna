
if Tasks.find().count() is 0
  now = new Date().getTime()


  eli = Meteor.users.insert
    createdAt: new Date '2014-03-09T06:13:10.759Z'
    _id : 'ci685TBmM8ihamdax'
    services : 
      'google' : 
        accessToken: ### access token value ###
        expiresAt: 1394349190554
        id: ### id value ###
        email: 'eli@elidoran.com'
        verified_email: true
        name: 'Eli Doran'
        given_name: 'Eli'
        family_name: 'Doran'
        picture: ### picture URL ###
        locale: 'en'
        gender: 'male'
      resume: 
        loginTokens: [ 
          'when' : new Date '2014-03-09T06:13:10.760Z'
          hashedToken: ### hashed token ###
        ] 
    profile: 
      name: 'Eli Doran' 

  eli = Meteor.users.findOne { _id: eli }

  if eli?
    Tasks.insert
      userId: eli._id
      author: eli.profile.name
      term: 'abc'
      submitted: now - 10 * 60 * 1000
      retrieved: now -  5 * 60 * 1000
      results:
        # ID  : DNA ref id
        one   : 'fweibhwelwndsukhk'
        two   : 'ibiwngbishgfekibg'
        three : 'bshegfksiyihiwbvs'
        four  : 'oqpxicubrbgjdiwyf'

    Tasks.insert
      userId: eli._id
      author: eli.profile.name
      term: 'defgh'
      submitted: now - 7 * 60 * 1000
      retrieved: now - 3 * 60 * 1000  
      results:
        a : 'jfjjejayunhiuihkwdgknagjdafu'
        b : 'vuahdafuvghehehknagjkwjghiui'
        c : 'ihkwjeavghdiugjuahejnudafuhn'
        d : 'hghfjdenknuaehvejauiuhuajihk'

    Tasks.insert
      userId: eli._id
      author: eli.profile.name
      term: 'ijklmnop'
      submitted: now - 2 * 60 * 1000
      retrieved: now - 1 * 60 * 1000  
      results:
        I   : 'jhehvghiuidgvuahehj'
        II  : 'jjayudgvehkwjeafuvg'
        III : 'ifjhehvghdauagjuahk'
        IV  : 'fjhdihknajaehvghfje'



