--use col10;

--copiar datos adicionales de localización andina de clientes y proveedores
---------------------------------------------------------------------------------
insert into col10..nsaif00666(nsaIFNit,nsaIF_CV,nsaIF_Type_Nit,nsaIF_Name,nsaIF_Address,PHNUMBR2,                                                                                                                                                                                            
						USERDEF1,USERDEF2,USRDEF03,USRDEF04,USRDEF05      )
	select nsaIFNit,nsaIF_CV,nsaIF_Type_Nit,nsaIF_Name,nsaIF_Address,PHNUMBR2,                                                                                                                                                                                            
			USERDEF1,USERDEF2,USRDEF03,USRDEF04,USRDEF05      
	from gcol..nsaif00666

insert into col10..nsaif01666(VENDORID,nsaIFNit,nsaIF_CV,VENDNAME,nsaIF_Type_Nit,nsaIF_Site_Code,                                                                                                                                                                                            
							Fsurname,Ssurname,Fname,Oname,Rsocial,CCode   )
	select VENDORID,nsaIFNit,nsaIF_CV,VENDNAME,nsaIF_Type_Nit,nsaIF_Site_Code,                                                                                                                                                                                            
			Fsurname,Ssurname,Fname,Oname,Rsocial,CCode 
	from gcol..nsaif01666

insert into col10..nsaif02666(CUSTNMBR,nsaIFNit,nsaIF_CV,CUSTNAME,nsaIF_Type_Nit,nsaIF_Site_Code,                                                                                                                                                                                            
			Fsurname,Ssurname,Fname,Oname,Rsocial,CCode )
	select CUSTNMBR,nsaIFNit,nsaIF_CV,CUSTNAME,nsaIF_Type_Nit,nsaIF_Site_Code,                                                                                                                                                                                            
	Fsurname,Ssurname,Fname,Oname,Rsocial,CCode 
	from gcol..nsaif02666


--SP_COLUMNS nsaif00666
--SP_COLUMNS nsaif01666
--SP_COLUMNS nsaif02666



sp_columns nsaPUC_GL10000
