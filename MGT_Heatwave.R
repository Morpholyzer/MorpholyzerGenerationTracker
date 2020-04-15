
# Renamer
e<-2
qass<-choose.dir("C:\\Users\\Public\\Documents\\MorpholyzerGentrack\\")
qassi<-qass
iqass<- paste(qass,"\\SingleCell\\Channel", sep= "")
ass<-paste(iqass,e)
fall<-list.files(ass,full.names = FALSE)
re<-grep("xxxxx",fall)
if (re==1){
  infop<-paste(qass,"\\info.txt",sep="")
  chn <- length(scan(infop,"input.data"))
  for (e in 2:chn){
    iqass<- paste(qass,"\\SingleCell\\Channel", sep= "")
    ass<-paste(iqass,e)
    pass<-paste(qass,"\\SingleCell\\Export\\Channel 2",sep= "")
    fall<-list.files(ass,full.names = FALSE)
    fallout<-list.files(pass,full.names = FALSE)
    ge<-list.files(ass,full.names = TRUE)
    goo<-length(fall)
    
    i<-1
    for (i in 1:length(fall)){ 
      faa<-fall[i]
      fe<-unlist(strsplit(faa," "))
      told<-fe[1]
      tolo<-unlist(strsplit(told,".tiff"))
      told<-tolo[1]
      cold<-fe[2]
      hold<-ge[i]
      loc<-0
      
      while(loc<goo){
        loc<-loc+1
        faal<-fallout[loc]
        fet<-unlist(strsplit(faal," "))
        nule<-fet[1]
        nule<-toString(nule)
        tchk<-fet[6]
        tochk<-unlist(strsplit(tchk,".jpg"))
        tchk<-tochk[1]
        if(told==tchk){
          gee<-paste(ass,"\\",sep="")
          gee<-paste(gee,nule,tchk)
          file.rename (hold,gee)
          break
        }
      }
    }
  }
}

# Heatwave
i<-2
we<-1
llo<-0
eallo<-0
iqass<- paste(qass,"\\SingleCell\\Channel", sep= "")
ass<-paste(iqass,i)
fal<-list.files(ass,full.names = TRUE)
cdex<-0
infop<-paste(qass,"\\info.txt",sep="")
chn <- length(scan(infop,"input.data"))
while(we<=length(fal)){
  gfl<-list.files(fal[we],full.names = TRUE)
  
  lll<-length(gfl)
  if (llo<lll){
    llo<-lll 
  }
  dex<-1
  while (dex<lll ){
    eab <- scan(gfl[dex],"input.data")
    eal<-length(eab)
    if (eallo<eal){
      eallo<-eal 
    }
    dex<-dex+1
    cdex<-cdex+1
  }
  
  
  we<-we+1
  
}

i<-5
for (i in 2:chn){
  
  iqass<- paste(qass,"\\SingleCell\\Channel", sep= "")
  ass<-paste(iqass,i)
  
  miass<-paste(qass,"\\Heatmaps\\Channel ",i,"\\DATA\\MIN",sep="")
  maass<-paste(qass,"\\Heatmaps\\Channel ",i,"\\DATA\\MAX",sep="")
  meass<-paste(qass,"\\Heatmaps\\Channel ",i,"\\DATA\\MEAN",sep="")
  suass<-paste(qass,"\\Heatmaps\\Channel ",i,"\\DATA\\SUM",sep="")
  
  
  dir.create(miass,recursive=TRUE)
  dir.create(maass,recursive=TRUE)
  dir.create(meass,recursive=TRUE)
  dir.create(suass,recursive=TRUE)
  
  fal<-list.files(ass,full.names = TRUE)
  gfls<-list.files(ass,full.names = FALSE)
  we<-1
  
  while(we<=(length(fal))){
    dex <- 1
    eaz<-matrix(0,eallo,llo)
    
    gfl<-list.files(fal[we],full.names = TRUE)
    lll<-length(gfl)
    
    while (dex<lll ){
      eab <- scan(gfl[dex],"input.data")
      for (ie in 1:length(eab)) {
        
        eaz[ie,dex]<- eab[ie]
      }
      dex<-dex+1
    }
    
    bus<-2
    tr<-0
    txx<-1
    while(txx<=dex){
      for(tr in 1:eallo){
        if (eaz[tr,txx]== 0){
          eaz[tr,txx]<-NA
        }
      }
      txx=txx+1
      tr<-0
    }
    
    vmin<-as.vector(1:(dex-2))
    vmean<-as.vector(1:(dex-2))
    vmax<-as.vector(1:(dex-2))
    vsum<-as.vector(1:(dex-2))
    
    
    while(bus<=(dex-1)){
      
      dfs<-as.double(eaz[,bus])
      dfs<-na.omit(dfs)
      
      
      fsum<-sum(dfs)
      fmax<-max(dfs)
      fmin<-min(dfs)
      fmean<- mean(dfs)
      
      vsum[bus-1]<-fsum
      vmax[bus-1]<-fmax
      vmin[bus-1]<-fmin
      vmean[bus-1]<- fmean
      
      
      bus<-bus+1
      
    }
    file.create(paste(maass,"/",gfls[we],".txt",sep=""))
    file.create(paste(miass,"/",gfls[we],".txt",sep=""))
    file.create(paste(meass,"/",gfls[we],".txt",sep=""))
    file.create(paste(suass,"/",gfls[we],".txt",sep=""))
    
    write.table(vmax,paste(maass,"/",gfls[we],".txt",sep=""),row.names=FALSE,col.names=FALSE)
    write.table(vmin,paste(miass,"/",gfls[we],".txt",sep=""),row.names=FALSE,col.names=FALSE)
    write.table(vmean,paste(meass,"/",gfls[we],".txt",sep=""),row.names=FALSE,col.names=FALSE)
    write.table(vsum,paste(suass,"/",gfls[we],".txt",sep=""),row.names=FALSE,col.names=FALSE)
    
    we<-we+1
  }
  
}

# MID
maass<-paste(qass,"\\Heatmaps\\MID",sep="")
dir.create(maass,recursive = TRUE)
datass<-paste(qass,"\\Heatmaps\\Channel 2\\DATA\\MEAN\\",sep="")
fal<-list.files(datass,full.names = F)
fal2<-list.files(datass,full.names = TRUE)
fall<-length(fal2)
i<-1


while(i<=fall){
  
  
  sf= unlist(strsplit(fal[i]," "))
  
  sf= unlist(strsplit(sf[3],".txt"))
  coo<-scan(fal2[i],"input.data")
  
  coo <- as.numeric(coo)
  coo<-na.omit(coo)
  foox<-length(coo)
  
  
  
  
  hfoxl<-foox/2
  hfoxl2<-hfoxl+1
  tfox1<-sum(coo[1:hfoxl])
  tfox2<-sum(coo[hfoxl2:(foox)])
  
  if(tfox1<tfox2){
    coo<-rev(coo)
    file.create(paste(maass,"\\",sf,"Z.txt",sep=""))
    write.table(coo,paste(maass,"\\",sf,"Z.txt",sep=""),row.names=FALSE,col.names=FALSE)
  }
  if(tfox1>tfox2){
    file.create(paste(maass,"\\",sf,".txt",sep=""))
    write.table(coo,paste(maass,"\\",sf,".txt",sep=""),row.names=FALSE,col.names=FALSE)
  }
  i<-i+1
}



# FILSAV (frame, ID, length,septum,area,volume)
#######################

lopp<-1
we<-1

datass<-paste(qass,"\\Heatmaps\\MID",sep="")
datasss<-paste(qass,"\\SingleCell\\Export\\Channel 1",sep="")
datassss<-paste(qass,"\\spt.txt",sep="")
fileConn<-file(datassss)
fal<-list.files(datass,full.names = FALSE)
falc<-length(fal)
falx<-list.files(datasss,full.names = FALSE)
lile <- vector(mode="character", length=length(falx))

while(we<=length(falx)){
   gflx<-falx[we]
   fex<-unlist(strsplit(gflx," "))
  fexr<-unlist(strsplit(fex[6],"T"))
  while(lopp<=falc){
    fexl<-unlist(strsplit(fal[lopp],"T"))
    grut<- substr(fexl[4],1,1)
    if(fexl[2]==fexr[2]){
      if(fexl[3]==fexr[3]){
        if(grut=="Z"){
          fox<-as.numeric(fex[5])
          fexx<-abs(1-fox)
          if(fexx==1){
            fexx<-0
          }
          
          fex[5]<-fexx
        }  
        
        
      }
    }
    
    
    lopp<-lopp+1
  }
  lopp<-1
  
  
  datt<-paste(fexr[3],fexr[2],"l",fex[1],"a",fex[3],"s",fex[5],sep="")
  lile[we]<-datt
  
  
  we<-we+1
  
}
write.table(lile,fileConn,row.names=FALSE,col.names=FALSE)


pass<-paste(qass,"\\SingleCell\\Channel 2\\",sep= "")
datassss<-paste(qass,"\\vol.txt",sep="")
fileConn<-file(datassss)
fall<-list.files(pass,full.names = FALSE)
falll<-length(fall)
mnl<-c(1:falll)
ei<-1
while(ei<=falll){
  spas<-paste(pass,fall[ei],sep="")
  sfal<-list.files(spas,full.names = FALSE)
  sfle<-length(sfal)
  sfle<-sfle-2
  fe<-unlist(strsplit(sfal[1]," "))
  aidi<-fe[3]
  aidi<-unlist(strsplit(aidi,".tiff"))
  nambr<-fe[7]
  naun<-unlist(strsplit(nambr,".txt"))
  naun<-as.numeric(naun)
  sliwi<-naun/sfle
  nl<-c(1:sfle)
  i<-1
  while(i<=sfle+1){
    fe<-unlist(strsplit(sfal[i]," "))
    nambr<-fe[7]
    naun<-unlist(strsplit(nambr,".txt"))
    naun<-as.numeric(naun)
    nl[i-1]<-naun
    i<-i+1  
  }
  i<-1
  while(i<=sfle){
    nl[i]<-nl[i]/2
    nl[i]<-nl[i]^2
    nl[i]<-nl[i]*pi
    nl[i]<-nl[i]*sliwi
    
    i<-i+1  
  }
  vol<-sum(nl)
  vol<-round(vol,4)
  koa<-paste(aidi,"v",vol,sep="")
  mnl[ei]<-koa
  ei<-ei+1
}
write.table(mnl,fileConn,row.names=FALSE,col.names=FALSE)


exp<-unlist(strsplit(qass,"\\",fixed=TRUE))
datavol<-paste(qass,"\\vol.txt",sep="")
datasep<-paste(qass,"\\spt.txt",sep="")
datajoin<-paste(qass,"\\",exp[6],"_ChronolistFILASV.txt",sep="")

rsep<-file(datasep)
rvol<-file(datavol)
fallsep<-read.table(rsep)
fallvol<-read.table(rvol)
falll<-nrow(fallsep)
fallll<-nrow(fallvol)
if (!(falll = fallll)){
  print()
}
sep<-as.vector(fallsep[1:falll,1])
vol<-as.vector(fallvol[1:falll,1])
mnl<-c(1:falll)
ei<-1
while(ei<=falll){
  lensep<-nchar(sep[ei])
  spsep<-substr(sep[ei],1,8)
  eiv<-1
  while(eiv<=falll){
    svol<-unlist(strsplit(vol[eiv],"T"))
    spvol<-paste(svol[3],svol[2],sep="")
    if (spsep==spvol){
      mnl[ei]<-paste(sep[ei],svol[4],sep="")
    }
    eiv<-eiv+1 
  }   
  ei<-ei+1
}

write.table(mnl,datajoin,row.names=FALSE,col.names=FALSE)
###################################################################

qass<-datajoin
ldj<-nchar(qass)
ldj<-ldj-4
exp<-substr(qass,1,ldj)
datajoin<-paste(qass,"\\",exp[6],sep="")

dir.create(exp)
rvol<-file(qass)
fallvol<-read.table(rvol)
fall<-nrow(fallvol)

vol<-as.vector(fallvol[1:fall,1])
mnl<-c(1:fall)
dr<-c(1:100)
dr[1:100]<-NA
ei<-1
while(ei<=fall){
  spsep<-substr(vol[ei],5,8)
  mnl[ei]<-spsep
  ei<-ei+1
}
umnl<-unique(mnl)
ul<-length(umnl)
wi<-1

while(wi<=ul){
  rd<-1
  ei<-1
  while(ei<=fall){
    
    spsep<-substr(vol[ei],5,8)
    if(umnl[wi]==spsep){
      dr[rd]<-vol[ei]
      rd<-rd+1
    }
    ei<-ei+1
  }
  dr<-sort(dr)
  drna<-length(dr[!is.na(dr)])
  crt<-1
  pnam<-substr (dr[crt],5,8)
  pfra<-c(1:drna)
  plen<-c(1:drna)
  pare<-c(1:drna)
  pvol<-c(1:drna)
  psep<-c(1:drna)
  while(crt<=drna){
    pvol2<-unlist(strsplit(dr[crt],"v"))
    pvol[crt]<-pvol2[2]
    pfra[crt]<-substr(dr[crt],2,4)
    plen[crt]<-substr(dr[crt],10,14)
    pare[crt]<-substr(dr[crt],16,20)
    crt<-crt+1
  }
  pfra<-as.numeric(pfra)
  pfra2<-as.numeric(length(pfra))
  pd<-pfra[1]
  pla<-1
  while(pla<=pfra2){
    pfra[pla]<-pfra[pla]-pd
    pfra[pla]<-pfra[pla]*3
    
    pla<-pla+1
  }
  
  pvol<-as.numeric(pvol)
  plen<-as.numeric(plen)
  pare<-as.numeric(pare)
  pde<-matrix(,nrow=3,ncol=drna)
  pde[1,]<-plen
  pde[2,]<-pare
  pde[3,]<-pvol
  psav<-paste(exp,"\\",pnam,"_LAVPlot.png",sep= "")
  png(psav)
  barplot(pde, beside=T,main=pnam,names.arg = pfra)
  
  dev.off()
  wi<-wi+1
  dr<-c(1:100)
  dr[1:100]<-NA
}
# Signal
qass<-qassi
api3<-paste(qass,"\\Heatmaps\\3area_SignalMean",sep="")
api5<-paste(qass,"\\Heatmaps\\5area_SignalMean",sep="")
dir.create(api3,recursive = TRUE)
dir.create(api5,recursive = TRUE)

posar<-NULL


mdat<-paste(qass,"\\Heatmaps\\MID",sep="")
sdat<-paste(qass,"\\Heatmaps\\Channel 4\\DATA\\MEAN",sep="")

mdatlit<-list.files(mdat,full.names = TRUE)
sdatlit<-list.files(sdat,full.names = TRUE)

mdatlif<-list.files(mdat,full.names = F)
sdatlif<-list.files(sdat,full.names = F)

mdatle<-length(mdatlif)
sdatle<-length(sdatlif)

i<-1



while(i<=mdatle){
  flip= F
  mdatna<-mdatlif[i]
  
  mna<-unlist(strsplit(mdatna,".txt"))
  mna2<-mna#unlist(strsplit(mna[2],".txt"))
  mnl<-nchar(mna2)
  mna3<-unlist(strsplit(mna2,"T"))
  mi<-mna3[2]
  mf<-mna3[3]
  if(mnl == 12){
    flip = T
  }
  i2<-1
  while (i2<=mdatle){
    sdatna<-sdatlif[i2]
    
    sna<-unlist(strsplit(sdatna," "))
    r<-3
    if (sna[2]=="xxxxx.txt"){
      r<-1
    }
    sna2<-unlist(strsplit(sna[r],".txt"))
    sna3<-unlist(strsplit(sna2,"T"))
    si<-sna3[2]
    sf<-sna3[3]
    if(si==mi){
      if(sf==mf){
        spos<-i2
      }
    }
    i2<-i2+1
  }
  
  cellpro<-scan(sdatlit[spos],"input.data")
  
  if(flip==T){
    cellpro=rev(cellpro)
  }
  cellpro<-as.numeric(cellpro)
  
  cellle<-length(cellpro)
  suble<-floor(cellle/5)
  suble2<-suble*2
  suble3<-suble*3
  suble4<-suble*4
  suble5<-suble*5
  
  subpro1<-sum(cellpro[1:suble])
  subpro1<-subpro1/suble
  subpro1<-floor(subpro1)
  
  subpro2<-sum(cellpro[(suble+1):suble2])
  subpro2<-subpro2/suble
  subpro2<-floor(subpro2)
  
  subpro3<-sum(cellpro[(suble2+1):suble3])
  subpro3<-subpro3/suble
  subpro3<-floor(subpro3)
  
  subpro4<-sum(cellpro[(suble3+1):suble4])
  subpro4<-subpro4/suble
  subpro4<-floor(subpro4)
  
  subpro5<-sum(cellpro[(suble4+1):suble5])
  subpro5<-subpro5/suble
  subpro5<-floor(subpro5)
  
  subpro6<-subpro2+subpro3+subpro4
  
  
  posar[1]<-subpro1
  posar[2]<-subpro2
  posar[3]<-subpro3
  posar[4]<-subpro4
  posar[5]<-subpro5
  posar[6]<-subpro6
  
  prostr5<-paste("O",subpro1,"OI",subpro2,"M",subpro3,"NI",subpro4,"N",subpro5,sep="")
  prostr<-paste("M",subpro6,sep="")
  
  file.create(paste(api3,"\\",mna2," ",prostr,".txt",sep=""))
  write.table(posar,paste(api3,"\\",mna2," ",prostr,".txt",sep=""),row.names=FALSE,col.names=FALSE)
  
  file.create(paste(api5,"\\",mna2," ",prostr5,".txt",sep=""))
  write.table(posar,paste(api5,"\\",mna2," ",prostr5,".txt",sep=""),row.names=FALSE,col.names=FALSE)
  
  i<-i+1
}


apip3<-paste(qass,"\\Heatmaps\\3area_SignalPlotMEAN\\",sep="")
apip5<-paste(qass,"\\Heatmaps\\5area_SignalPlotMEAN\\",sep="")

dir.create(apip3,recursive = TRUE)
dir.create(apip5,recursive = TRUE)

apidatlit<-list.files(api5,full.names = TRUE)
apidatlif<-list.files(api5,full.names = FALSE)
apile<-length(apidatlif)

o<-NULL
oi<-NULL
m<-NULL
ni<-NULL
n<-NULL
mm<-NULL

test<-0

idlistpre<-NULL
idlist<-NULL
idcount<-NULL
count<-0
####get unique id
i<-1
while(i<=apile){
  sdatna<-apidatlif[i]
  
  sna<-unlist(strsplit(sdatna," "))
  sna2<-unlist(strsplit(sna[1],"T"))
  
  
  si<-sna2[2]
  sf<-sna2[3]
  idlistpre[i]<-si
  i<-i+1
}
idlist<-unique(idlistpre)
idle<-length(idlist)

#### count id
idi<-1

while(idi<=idle){
  i<-1
  siu<-idlist[idi]
  while(i<=apile){
    si<-idlistpre[i]
    
    if(si==siu){
      count<-count+1  
    }
    i<-i+1
  }
  idcount[idi]<-count
  idi<-idi+1
  count<-0
}

#### excract and plot

idi<-1

while(idi<=idle){
  i<-1
  ip<-1
  siu<-idlist[idi]
  while(i<=apile){
    si<-idlistpre[i]
    
    if(si==siu){
      cellpro<-scan(apidatlit[i],"input.data")   
      o[ip]<-cellpro[1]
      oi[ip]<-cellpro[2]
      m[ip]<-cellpro[3]
      ni[ip]<-cellpro[4]
      n[ip]<-cellpro[5]
      mm[ip]<-cellpro[6]
      test<-test+1
      ip<-ip+1
    }
    i<-i+1
  }
  pnam<-"Old Pole"
  psav<-paste(apip5,"\\",siu,"_OldPole-Plot.png",sep= "")
  png(psav)
  plot(o, beside=F,main=pnam,ylim=c(50,300))
  dev.off()
  
  pnam<-"Old intermediate Pole"
  psav<-paste(apip5,"\\",siu,"_OldintermediatePole-Plot.png",sep= "")
  png(psav)
  plot(oi, beside=F,main=pnam,ylim=c(50,300))
  dev.off()
  
  pnam<-"New intermediate Pole"
  psav<-paste(apip5,"\\",siu,"_NewintermediatePole-Plot.png",sep= "")
  png(psav)
  plot(ni, beside=F,main=pnam,ylim=c(50,300))
  dev.off()
  
  pnam<-"New Pole"
  psav<-paste(apip5,"\\",siu,"_NewPole-Plot.png",sep= "")
  png(psav)
  plot(n, beside=F,main=pnam,ylim=c(50,300))
  dev.off()
  
  pnam<-"Midcell"
  psav<-paste(apip5,"\\",siu,"_Midcell-Plot.png",sep= "")
  png(psav)
  plot(m, beside=F,main=pnam,ylim=c(50,300))
  dev.off()
  
  pnam<-"3area"
  psav<-paste(apip3,"\\",siu,"_3area-Plot.png",sep= "")
  png(psav)
  plot(mm, beside=F,main=pnam,ylim=c(100,600))
  dev.off()
  
  
  
  idi<-idi+1
  o<-NULL
  oi<-NULL
  m<-NULL
  ni<-NULL
  n<-NULL
  mm<-NULL
}
mexnal<-unlist(strsplit(qass,"\\",fixed=T))
mexl<-length(mexnal)
mexna<-mexnal[mexl]
datajoin3<-paste(qass,"\\Heatmaps\\",mexna,"_ChronolistSignal3Area.txt",sep="")
datajoin5<-paste(qass,"\\Heatmaps\\",mexna,"_ChronolistSignal5Area.txt",sep="")

mdatlif<-list.files(api5,full.names = F)
mle<-length(mdatlif)
apilist<-NULL
i<-1
while(i<=mle){
  mna<-unlist(strsplit(mdatlif[i]," "))
  mapo<-mna[2]
  maopl<-nchar(mapo)-4
  mapo<-substr(mapo,1,maopl)
  mnif<-unlist(strsplit(mna[1],"T"))
  mi<-mnif[2]
  mf<-mnif[3]
  
  apistr<-paste(mi,mf,mapo,sep="")
  apilist[i]<-apistr
  i<-i+1
}
file.create(paste(datajoin5,sep=""))
write.table(apilist,datajoin5,row.names=FALSE,col.names=FALSE)

mdatlif<-list.files(api3,full.names = F)
mle<-length(mdatlif)
apilist<-NULL
i<-1
while(i<=mle){
  mna<-unlist(strsplit(mdatlif[i]," "))
  mapo<-mna[2]
  maopl<-nchar(mapo)-4
  mapo<-substr(mapo,1,maopl)
  mnif<-unlist(strsplit(mna[1],"T"))
  mi<-mnif[2]
  mf<-mnif[3]
  
  apistr<-paste(mi,mf,mapo,sep="")
  apilist[i]<-apistr
  i<-i+1
}
file.create(paste(datajoin3,sep=""))
write.table(apilist,datajoin3,row.names=FALSE,col.names=FALSE)


#table
exp<-unlist(strsplit(qass,"\\",fixed=TRUE))
datajoin<-paste(qass,"\\",exp[6],"_ChronoTABLE.txt",sep="")

fra<-NULL
len<-NULL
id<-NULL
se<-NULL
ar<-NULL
vo<-NULL
msi<-NULL

lopp<-1
we<-1
datass<-paste(qass,"\\Heatmaps\\",sep="")

fal<-list.files(datass,full.names = T)


falx<-list.files(qass,full.names = T)
lile <- vector(mode="character", length=length(falx))

x<-"ChronolistSignal3Area.txt"
y<-"ChronolistFILASV.txt"
posv =grep(y,falx)
posm =grep(x,fal)

pm<-scan(fal[posm],"input.data")
pv<-scan(falx[posv],"input.data")

we<-1

lepm<-length(pm)
lepv<-length(pv)



while(we<=lepv){
  
  posa = regexpr("a", pv[we])
  posa<-as.numeric(posa)
  posl = regexpr("l", pv[we])
  posl<-as.numeric(posl)
  posv = regexpr("v", pv[we])
  posv<-as.numeric(posv)
  poss = regexpr("s", pv[we])
  poss<-as.numeric(poss)
  
  idp<-substr(pv[we],5,8)
  frp<-substr(pv[we],1,4)
  pat<-paste(idp,frp,sep="")
  
  
  fra[we]<-substr(pv[we],2,4)
  len[we]<-substr(pv[we],posl+1,posa-1)
  id[we]<-substr(pv[we],6,8)
  se[we]<-substr(pv[we],poss+1,posv-1)
  ar[we]<-substr(pv[we],posa+1,poss-1)
  vo[we]<-substr(pv[we],posv+1,nchar(pv[we]))
  posc = regexpr("a", pm[1]) # Returns position of 1st match in a string
  
  mloc<-grep(pat,pm)
  mst<-pm[mloc]
  posm = regexpr("M", mst)
  posm<-as.numeric(posm)
  msi[we]<-substr(pm[mloc],posm+1,nchar(pm[mloc]))
  
  fra<-as.numeric(fra)
  len<-as.numeric(len)
  id<-as.numeric(id)
  se<-as.numeric(se)
  ar<-as.numeric(ar)
  vo<-as.numeric(vo)
  msi<-as.numeric(msi)
  
  we<-we+1 
}

x<-data.frame("frame" =fra,"id"=id,"length"=len,"area"=ar,"volume"=vo,"septum_position"=se,"signal"=msi)
y<- x[order(x$id,x$frame),]
write.table(y,datajoin,row.names=FALSE,col.names=T)
