require 'rubygems'
require 'highline/import'


def hilite(text)
  #http://pueblo.sourceforge.net/doc/manual/ansi_color_codes.html
  blue = '34'
  green = '32'
  red = '31'
  #http://highline.rubyforge.org/doc/classes/HighLine.html
  return "\e["+blue+"m"+text+"\e[0m"
end

basicWordVal = /[\D]{2}/#No digits, at least 2 letters
Quest = Struct.new :prompt, :validation, :response

questions=[
(Quest.new "Give me a VERB: ", basicWordVal, "How about a real verb?"),
(Quest.new "Give me an ADJECTIVE: ", basicWordVal, "How about a real adjective?"),
(Quest.new "Give me a NOUN (PLURAL): ", basicWordVal, "Please try again"),
(Quest.new "Give me an ADJECTIVE: ", basicWordVal, "Please try again"),
(Quest.new "Give me a VERB ENDING IN 'ING': ", /[\w]{2}ing/, "Please try again"),
(Quest.new "Give me a VERB: ", basicWordVal, "Is that a verb?"),
(Quest.new "Give me a NUMBER: ", /^\S\d+$/, "Number keys only please"),
(Quest.new "Give me an ADJECTIVE: ",basicWordVal, "Please try again"),
(Quest.new "Give me another ADJECTIVE: ",basicWordVal, "Please try again"),
(Quest.new "Give me a NOUN (PLURAL): ",basicWordVal, "Please try again"),
(Quest.new "Give me another NOUN (PLURAL): ",basicWordVal, "Please try again"),
(Quest.new "Give me A MALE NAME: ",/[\w]+/, "Please try again"),
(Quest.new "Give me an ADJECTIVE: ",basicWordVal, "Please try again"),
(Quest.new "Give me another ADJECTIVE: ",basicWordVal, "Please try again"),
(Quest.new "(Last one!) Give me a NOUN (PLURAL): ",basicWordVal, "Please try again")]

answers=[]

say "\n\n\n\n\n\n\n\n\n\n\n\n\n\n##########################################\n##########################################\n\nLet's play mad libs!\n\nI'm going to ask you for a series of words, and when we're finished, I'll compile your mad lib.\n\nLet's get started!\n\n##########################################\n##########################################\n\n"



questions.length.times {|i| 
  quest = questions[i]
  answers[i] = ask(quest.prompt){|q|
    q.responses[ :not_valid ] = quest.response
    #Array indexing works too!
    #q.validate = questions[i][1]; 
    q.validate = quest.validation;
  }
}
 

questions.length.times {|i| 
  if answers[i] == ""
    answers[i] = "(no answer given)" 
  end
  answers[i] = hilite(answers[i])
}

madlibText = "Come #{answers[0]} at Trevor's Ruby Tuesday Class, where you`ll receive #{answers[1]} information on all of your favorite  #{answers[2]}. Our #{answers[3]} and #{answers[4]} coworkers are there to #{answers[5]} you #{answers[6]} hours a day. Here you will find #{answers[7]} answers to any #{answers[8]} questions you may have. We have #{answers[9]} for the front end geeks, #{answers[10]} for the middleware nerds and all the latest what-nots for your aunt #{answers[11]}. So come on down to your #{answers[12]} #{answers[13]} classroom where the #{answers[14]} come first."




  
  
  
say "\n\n\n\n\n\n\n##########################################\n##########################################\n\nGreat job! Here's your mad lib:\n\n#{madlibText}\n\n"