#'
#' @title messageDS.o
#' @description This function allows for error messages arising from the 
#' running of a server-side assign function to be returned to the client-side
#' @param message.obj is a character string, containing the name of the list containing the
#' message. See the header of the client-side function ds.message.o for more details.
#' #' @return a list object from each study, containing whatever message has been written by
#' DataSHIELD into $studysideMessage.
#' @author Burton PR
#' @export
#' 
messageDS.o <- function(message.object.name){

#############################################################
#MODULE 1: CAPTURE THE nfilter SETTINGS                     #
thr<-listDisclosureSettingsDS.o()				#
#nfilter.tab<-as.numeric(thr$nfilter.tab)					#
#nfilter.glm<-as.numeric(thr$nfilter.glm)					#
nfilter.subset<-as.numeric(thr$nfilter.subset)          	#
nfilter.string<-as.numeric(thr$nfilter.string)              #
nfilter.stringShort<-as.numeric(thr$nfilter.stringShort)    #
nfilter.kNN<-as.numeric(thr$nfilter.kNN)                    #
#############################################################

#TEST IF message.object.name EXISTS AS AN OBJECT ON SERVERSIDE
#exists() must have message.object.name explicitly specified in inverted commas.
#NOT just the name of a character class object representing the name without
#inverted comma

A1.exists.text<-paste0("exists('",message.object.name,"')")

boole.A1.exists<-eval(parse(text=A1.exists.text))




if(!boole.A1.exists) {
out.obj<-"Error: the object <message.obj> does not exist in this datasource" 
return(out.obj)
}



#IF message.object.name EXISTS, CHECK WHETHER IT CURRENTLY CONTAINS A studysideMessage

if(boole.A1.exists){
message.object.name.active<-eval(parse(text=message.object.name))



#CASE WHERE PRIMARY OUTPUT OBJECT IS A LIST 
if(class(message.object.name.active)=="list"){

#A LIST WITH NAMES - could be a studysideMessage
	if(!is.null(names(message.object.name.active)))	{
		s.message.available<-FALSE
		for(j in length(names(message.object.name.active))){
			if(names(message.object.name.active)[j]=="studysideMessage"){
			s.message.available<-TRUE
			out.obj<-message.object.name.active$studysideMessage
			}
		}
		if(!s.message.available){
			out.obj<-"ALL OK: there are no studysideMessage(s) on this datasource"
		}
	}

#A LIST WITHOUT NAMES
	if(is.null(names(message.object.name.active)))	{
	out.obj<-"Outcome object is a list without names. So a studysideMessage may be hidden. Please check output is OK"
	}

}else{	
#CASE WHERE PRIMARY OUTPUT IS AN OBJECT OF A CLASS OTHER THAN LIST - output object created OK and so no studysideMessage
	out.obj<-"ALL OK: there are no studysideMessage(s) on this datasource"
	}

  }  

   return(MESSAGE=out.obj)

}
#AGGREGATE FUNCTION
# messageDS.o


