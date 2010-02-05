=================================================================
==                                                             ==
==                       HugFlash Ver.2.7                      ==
==                                                             ==
==                                                             ==
==http://www.paw.hi-ho.ne.jp/milbesos/   (C)2009 MilBesos Co.  ==
=================================================================
                                            translated by Excite.

- In the beginning
 To extract the images, the sounds, and the videos included 
in flash file (SWF/FLV/F4V), this 'HugFlash' was produced. 

- Output format
	PCM(WAVE) Audio
	ADPCM Audio(decode to PCM)
	Nellymoser Audio(decode to PCM)
	Speex Audio(decode to PCM)
	MP3 Audio
	BMP Image
	JPEG Image
	PNG Image
	GIF Image
	SorensonH.263 Video(AVI format)
	ScreenVideo(V2 is not supported)(AVI format)
	On2VP6 Video(AVI format)
	H264/AVC Video(MP4/M4A/AVI format)
	ActionScript, etc...

- Input object
	SWF
	FLV(Flash Video)
	F4V/MP4(H264/AVC)
	EXE(projector file for Windows of flash base)
	SCR(screen saver file)
	etc.(all files included flash data)

- System requirements
 Only for Windows. 
 Confirmed operation in Windows Me/XP. Maybe it operates of other OS. 
 It is preferable that equipped with an enough memory 
and HDD empty capacity. 

 This application is made from Visual C++6.0 MFC. Therefore, it seems 
to be put by the standard since Windows 98 SE though the run time 
such as MFC42.DLL is necessary.

 DirectShow might be used at the decode of On2VP6. 
 In that case, it is necessary to install DirectX. 
 I think it is unquestionable it is since 8.0(If it is XP, it is 8.1) though 
confirms the operation in 9.0c. 

*Codec
 1. The VP6 codec is necessary for the decode of VP6. Please obtain each one. 
 2. The video data can be output at high speed without deterioration by installing ffdshow. 
 3. If you want to convert MP4(H264/AVC) to AVI, the H264 VFW Decoder(i.e. ffdshow) is necessary.

 In conclusion, it only has to install FFDSHOW. 

- Version of Flash to be able to confirm the operation 
	SWF:Ver10 and lower
	FLV:Ver1

- Version of ActionScript
	ActionScript3.0(ABC file version:minor16/major46) and lower

- File composition
	hugflash.exe (main)
	chao.exe (for uninstallation)
	libfaad2.dll (DLL for AAC2PCM)
	libspeex.dll (DLL for SPX2PCM)
	huglng_eng.dll (languege DLL for English)
	hugflash.chm (HTML Help for Japanease)
	readme.txt (for Japanease)
	readme_eng.txt (this book)


- Installation
 The 'hugflash*_*'(*_* is a version, and same) folder can be done by decompressing hugflash*_*.lzh.
 And puts it on the favor place. 


- Use
 Excute 'hugflash.exe'. 


- Operation method
 Please see OnlineHelp translated by Excite. Sorry, 'hugflash.chm' is only for Japanease. 


- Uninstallation
 Excute 'chao.exe'. Information on the registry related to this application 
program is deleted. 
 After this, please delete each 'hugflash*_*' folder after moving necessary files. 


- Exemption matters
 The copyright is not abandoned though this application is a freeware. 
Å@Å@
 I do not assume the responsibility to damages or troubles by this application.

 This application is the one made to enjoy it privately. 
 Please handle media made so as not to collide with the law and the right. 

 Especially, please take the confirmation in those who produce the flash 
when you secondarily use the extracted file. 
 Please follow the rule that has been decided on the those who produce it 
including the handling of the flash file.


Home Page : http://www.paw.hi-ho.ne.jp/milbesos/
OnlineHelp(translated by Excite):http://www.excite.co.jp/world/english/web/?wb_url=http%3A%2F%2Fwww.paw.hi%2Dho.ne.jp%2Fmilbesos%2Fhelp%2Fcontents%2Fhugflash%2Findex.html&wb_lp=JAEN&wb_dis=2
Support Page: http://hp.vector.co.jp/authors/VA033596/
mail: milbesos@hotmail.com
