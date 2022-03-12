print"Welcome to Samar Quize about programmer "

EasyQuize ="""A programmer, computer programmer, ___1___ , dev, coder, or software engineer is a person who creates computer ___2___ . The term computer programmer can refer to a specialist in one area of computer programming or to a generalist who writes code for many kinds of software. One who practices or ___3___ a formal approach to programming may also be known as a programmer ___4___ """

EasyAnswer=["developer","software","professes","analyst"]

MediumQuize="""Computer ___1___ often are grouped into two broad types: ___2___ programmers and ___3___ programmers. Application programmers write programs to handle a specific job, such as a program to track inventory within an organization. They also may revise existing ___4___ software or customize generic applications which are frequently purchased from independent software vendors."""

MediumAnswer=["programmers","application","system", "packaged"]

HardQuize="""Programming editors, also known as source code ___1___, are text editors that are specifically designed for ___2___ or ___3___ for writing the source code of an application or a program. Most of these editors include features useful for programmers, which may include color syntax highlighting, auto indentation, auto-complete, bracket matching, syntax check, and allows plug-ins. These features aid the users during coding, ___4___ and testing."""

HardAnswer=["editors","programmers","developers","debugging"]
  
blanks=["___1___","___2___","___3___","___4___"]

levels=["easy","medium","hard"]


def possibilities():
    level = ''
    while level not in levels:

		level = raw_input("Please , Choose quize level from The following choostions : easy  , medium, hard ")

		if level == "easy":

			runeasy(EasyQuize)

		elif level == "medium":

			runmedium(MediumQuize)

		elif level == "hard":

		    runhard(HardQuize)

		else:

		    return level


def runeasy(Quize1) :   
 "A programmer, computer programmer, developer, dev, coder, or software engineer is a person who creates computer software. The term computer programmer can refer to a specialist in one area of computer programming or to a generalist who writes code for many kinds of software. One who practices or professes a formal approach to programming may also be known as a programmer analyst"    
 checkinput(Quize1,EasyAnswer,blanks)
 print ("Greet Job ")
 runmedium(MediumQuize)


def runmedium(Quize2):

 "Computer programmers often are grouped into two broad types: application programmers and systems programmers. Application programmers write programs to handle a specific job, such as a program to track inventory within an organization. They also may revise existing packaged software or customize generic applications which are frequently purchased from independent software vendors."
 checkinput(Quize2,MediumAnswer,blanks)
 print ("Greet Job ")
 runhard(HardQuize)

def runhard(Quize3):
 "Programming editors, also known as source code editors, are text editors that are specifically designed for programmers or developers for writing the source code of an application or a program. Most of these editors include features useful for programmers, which may include color syntax highlighting, auto indentation, auto-complete, bracket matching, syntax check, and allows plug-ins. These features aid the users during coding, debugging and testin"
 checkinput(Quize3,HardAnswer,blanks)
 print ("Greet Job \n Congratulations, you have finished the quiz")


def checkinput(Quize, answers, blanks):
 blank_Index = 0
 print Quize
 while blank_Index<len(blanks):
  result= raw_input("Please , Enter the word in the blank: ").lower()
  if result == answers[blank_Index] :
    Quize = Quize.replace(blanks[blank_Index],answers[blank_Index])
    blank_Index += 1
  else:
       print"Incorrect , please try again"   
  print Quize

possibilities()
