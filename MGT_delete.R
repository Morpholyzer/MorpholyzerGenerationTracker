qass<-choose.dir("C:\\Users\\Public\\Documents\\MorpholyzerStill")
qpo<-paste(qass,"\\Polish\\",sep="")

fal<-list.files( qpo,full.names = F)
fol<-length(fal)
cou<-1
while(cou<=fol){
fe<-unlist(strsplit(fal[cou]," "))
fe1<-unlist(strsplit(fe[6],".jpg"))
fe2<-unlist(strsplit(fe1[1],"T"))

id<-fe2[2]
idf<-fe2[3]
idc<-grepl(pattern = 'i',id)

qdi<-c(1:17)
qdi[1]<-paste(qass,"\\Channel 2\\",sep="")
qdi[2]<-paste(qass,"\\Channel 3\\",sep="")
qdi[3]<-paste(qass,"\\Channel 4\\",sep="")
qdi[4]<-paste(qass,"\\SingleCell\\Channel 2\\",sep="")
qdi[5]<-paste(qass,"\\SingleCell\\Channel 3\\",sep="")
qdi[6]<-paste(qass,"\\SingleCell\\Channel 4\\",sep="")
qdi[7]<-paste(qass,"\\SingleCell\\Export\\Channel 1\\",sep="")
qdi[8]<-paste(qass,"\\SingleCell\\Export\\Channel 2\\",sep="")
qdi[9]<-paste(qass,"\\SingleCell\\Export\\Channel 3\\",sep="")
qdi[10]<-paste(qass,"\\SingleCell\\Export\\Channel 4\\",sep="")
qdi[11]<-paste(qass,"\\SingleCell\\Export\\Overlay 1\\",sep="")
qdi[12]<-paste(qass,"\\SingleCell\\Export\\Overlay 2\\",sep="")
qdi[13]<-paste(qass,"\\SingleCell\\Export\\Overlay 3\\",sep="")
qdi[14]<-paste(qass,"\\SingleCell\\Export\\Overlay 4\\",sep="")
qdi[15]<-paste(qass,"\\SingleCell\\ROI\\",sep="")
qdi[16]<-paste(qass,"\\SingleCell\\Sink\\",sep="")
qdi[17]<-paste(qass,"\\SingleCell\\OriginalExecuted\\",sep="")
qdi[20]<-paste(qass,"\\Channel 5\\",sep="")
qdi[18]<-paste(qass,"\\SingleCell\\Channel 5\\",sep="")
qdi[19]<-paste(qass,"\\SingleCell\\Export\\Channel 5\\",sep="")
qdi[23]<-paste(qass,"\\SingleCell\\Original\\",sep="")
cl<-1
while(cl<=17){
sfal<-list.files(qdi[cl],full.names = TRUE)
sfalF<-list.files(qdi[cl],full.names = F)

sal<-length(sfal)

co<-1
while(co<=sal){
tf<-grepl(pattern = id,sfal[co])
ti<-grepl(pattern = idf,sfal[co])

if(tf==TRUE) {
  if(ti==TRUE) {
    if(cl==16){
      des<-paste(qdi[23],sfalF[co],sep="")
      file.copy(sfal[co],des)
    }
    
    
  unlink(sfal[co],recursive = TRUE)

  }
}
co<-co+1

}
cl<-cl+1
}
cou<-cou+1
}