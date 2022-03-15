public without sharing class InscripcionesFormController {
    public Contact alu {get;set;}
    public Opportunity opp {get;set;}
    public List<SelectOption> niveles {get;set;}
    public List<SelectOption> sedes {get;set;}
    public List<SelectOption> sites {get;set;}
    public List<SelectOption> turnos {get;set;}
    public List<SelectOption> programas {get;set;}
    public List<SelectOption> estadociviles {get;set;}
    public List<SelectOption> nacionalidades {get;set;}
    public List<SelectOption> sexos {get;set;}
    public List<SelectOption> billingstates {get;set;}
    public Account programaSelected {get;set;}
    public Boolean esVirtual {get;set;}
    public Id oppId {get;set;}
    public Id ProgRTId {get;set;}
    
    public String FirstName {get;set;}
    public String ApellidoPaterno {get;set;}
    public String ApellidoMaterno {get;set;}
    public String Nombredeltutorc {get;set;}
    public String Emaildeltutorc {get;set;}
    public String Telefonodeltutorc {get;set;}
    public String PersonMobilePhone {get;set;}
    public String PersonEmail {get;set;}
    public String Nacionalidadc {get;set;}
    public String CURPc {get;set;}
    public String EstadoCivilc {get;set;}
    public String Sexoc {get;set;}
    public Date PersonBirthdate {get;set;}
    public Boolean MayorDeEdad {get;set;}
    public String DiaNacimiento {get;set;}
    public List<SelectOption> dias {get;set;}
    public String MesNacimiento {get;set;}
    public List<SelectOption> meses {get;set;}
    public String AnoNacimiento {get;set;}
    public List<SelectOption> anos {get;set;}
    public String Calle {get;set;}
    public String Numero {get;set;}
    public String Colonia {get;set;}
    public String BillingCity {get;set;}
    public String BillingState {get;set;}
    public String BillingPostalCode {get;set;}
    public String Escueladeprocedenciac {get;set;}
    
    public String Tipodecarrerac {get;set;}
    public String Programac {get;set;}
    public hed__Term__c Plazo {get;set;}
    public String Modalidadc {get;set;}
    public String Sedec {get;set;}
    public String Sitec {get;set;}
    public String Jornadac {get;set;}
    public String Aceptterminosc {get;set;}
    
    public Boolean HayErrores {get;set;}
    
    public InscripcionesFormController(){
        ProgRTId =  Schema.SObjectType.Account.getRecordTypeInfosByName().get('Academic Program').getRecordTypeId();
        MayorDeEdad = false;
        HayErrores = false;
        oppId = apexpages.currentpage().getparameters().get('id');
        niveles = new List<SelectOption>();
        niveles.add(new SelectOption('Prepa UMM','Prepa UMM'));
        niveles.add(new SelectOption('Profesional','Profesional'));
        niveles.add(new SelectOption('Posgrado','Maestria'));

        opp = [select ContactId, Programa_Acad_mico__c from Opportunity where id =: oppId];
        alu = [select Name, FirstName, LastName, Phone, Email, Nacionalidad__c, CURP__c, Estado_Civil__c, Sexo__c, Birthdate, MailingStreet, MailingCity, 
               MailingState, MailingPostalCode, Escuela_de_procedencia__c,  Email_del_tutor__c, Nombre_del_tutor__c, Telefono_del_tutor__c, Primer_Apellido__c, Segundo_Apellido__c              
              from Contact
              where id =: opp.ContactId LIMIT 1];
        ProgramaSelected = [select nivel_de_estudio__c, programa_largo__c, sede__c, site__c, jornada__c, modalidad__c from Account where Id =: opp.Programa_Acad_mico__c];
        
        FirstName = alu.FirstName;
        ApellidoPaterno = alu.Primer_Apellido__c;
        ApellidoMaterno = alu.Segundo_Apellido__c;
        Nombredeltutorc = alu.Nombre_del_tutor__c;
        Emaildeltutorc = alu.Email_del_tutor__c;
        Telefonodeltutorc = alu.Telefono_del_tutor__c;
        PersonMobilePhone = alu.Phone;
        PersonEmail = alu.Email;
        Nacionalidadc = alu.Nacionalidad__c;
        CURPc = alu.CURP__c;
        EstadoCivilc = alu.Estado_Civil__c;
        Sexoc = alu.Sexo__c;
        PersonBirthdate = alu.Birthdate;
        Calle = alu.MailingStreet;
        BillingCity = alu.MailingCity;
        BillingState = alu.MailingState;
        BillingPostalCode = alu.MailingPostalCode;
        Escueladeprocedenciac = alu.Escuela_de_procedencia__c;
        
        sedec = ProgramaSelected.Sede__c;
        sitec = ProgramaSelected.Site__c;
        jornadac = ProgramaSelected.Jornada__c;
        
        
        
        
        sedes = new List<SelectOption>();
        sites = new List<SelectOption>();
        turnos = new List<SelectOption>();
        estadociviles = new List<SelectOption>();
        sexos = new List<SelectOption>();
        billingstates = new List<SelectOption>();
        nacionalidades = new List<SelectOption>();
        
        estadociviles.add(new SelectOption('','--Selecciona un estado civil--'));
        estadociviles.add(new SelectOption('Casado','Casado'));
        estadociviles.add(new SelectOption('Divorcio','Divorcio'));
        estadociviles.add(new SelectOption('Soltero','Soltero'));
        estadociviles.add(new SelectOption('Viudo','Viudo'));
        
        sexos.add(new SelectOption('Mujer','Mujer'));
        sexos.add(new SelectOption('Hombre','Hombre'));
        
        nacionalidades.add(new SelectOption('Mexicana','Mexicana'));
        nacionalidades.add(new SelectOption('Extranjero','Extranjero'));

		billingstates.add(new SelectOption('Aguascalientes','Aguascalientes'));        
        billingstates.add(new SelectOption('Baja California','Baja California'));
        billingstates.add(new SelectOption('Baja California Sur','Baja California Sur'));
        billingstates.add(new SelectOption('Campeche','Campeche'));
        billingstates.add(new SelectOption('Chiapas','Chiapas'));
        billingstates.add(new SelectOption('Chihuahua','Chihuahua'));        
        billingstates.add(new SelectOption('Ciudad de México','Ciudad de México'));
        billingstates.add(new SelectOption('Coahuila','Coahuila'));
        billingstates.add(new SelectOption('Colima','Colima'));
        billingstates.add(new SelectOption('Durango','Durango'));
        billingstates.add(new SelectOption('Guanajuato','Guanajuato'));        
        billingstates.add(new SelectOption('Guerrero','Guerrero'));
        billingstates.add(new SelectOption('Hidalgo','Hidalgo'));
        billingstates.add(new SelectOption('Jalisco','Jalisco'));
        billingstates.add(new SelectOption('México','México'));
        billingstates.add(new SelectOption('Michoacán','Michoacán'));        
        billingstates.add(new SelectOption('Morelos','Morelos'));
        billingstates.add(new SelectOption('Nayarit','Nayarit'));
        billingstates.add(new SelectOption('Nuevo León','Nuevo León'));
        billingstates.add(new SelectOption('Oaxaca','Oaxaca'));
        billingstates.add(new SelectOption('Puebla','Puebla'));        
        billingstates.add(new SelectOption('Querétaro','Querétaro'));
        billingstates.add(new SelectOption('Quintana Roo','Quintana Roo'));
        billingstates.add(new SelectOption('San Luis Potosí','San Luis Potosí'));
        billingstates.add(new SelectOption('Sinaloa','Sinaloa'));
        billingstates.add(new SelectOption('Sonora','Sonora'));        
        billingstates.add(new SelectOption('Tabasco','Tabasco'));
        billingstates.add(new SelectOption('Tamaulipas','Tamaulipas'));
        billingstates.add(new SelectOption('Tlaxcala','Tlaxcala'));
        billingstates.add(new SelectOption('Veracruz','Veracruz'));
        billingstates.add(new SelectOption('Yucatán','Yucatán'));
        billingstates.add(new SelectOption('Zacatecas','Zacatecas'));
        
        
        
        
        Tipodecarrerac = ProgramaSelected.Nivel_de_estudio__c;
        getProgramas(Tipodecarrerac);        
        Programac = ProgramaSelected.id;
        Plazo = [SELECT Id FROM hed__Term__c WHERE hed__Account__c =: ProgramaSelected.Id];
        Modalidadc = ProgramaSelected.Modalidad__c;
        SelectPrograma();
        if(PersonBirthdate != null){
            MayorDeEdad = System.today().year() - PersonBirthdate.year() > 17;
        }
    }
    
    
    public PageReference Registrar(){
        System.debug('Validando edad');
        MayorDeEdad = System.today().year() - PersonBirthdate.year() > 17;
        if(!MayorDeEdad && Nombredeltutorc == '' && Emaildeltutorc == '' && Telefonodeltutorc == ''){
            return null;
        }
        if(!Boolean.valueOf(Aceptterminosc)){
            HayErrores = true;
            return null;
        }
        
        HayErrores = false;
        hed__Application__c app = new hed__Application__c();
        app.Opportunity__c = opp.Id;
        app.FirstName__c = FirstName;
        app.Primer_Apellido__c = ApellidoPaterno;
        app.Segundo_Apellido__c = ApellidoMaterno;
        app.Nombre_del_alumno__c = FirstName + ' ' + ApellidoPaterno + ' ' + ApellidoMaterno;
        app.Celular__c = PersonMobilePhone;
        app.Correo_electronico__c = PersonEmail;
        app.Nombre_del_tutor__c = Nombredeltutorc;
        app.Email_del_tutor__c = Emaildeltutorc;
        app.Telefono_del_tutor__c = Telefonodeltutorc;
        app.Nacionalidad__c = Nacionalidadc;
        app.CURP__c = CURPc;
        app.Estado_Civil__c = EstadoCivilc;
        app.Sexo__c = Sexoc;
        app.PersonBirthdate__c = PersonBirthdate;
        app.ShippingStreet__c = Calle;
        app.ShippingCity__c = BillingCity;
        app.ShippingState__c = BillingState;
        app.ShippingPostalCode__c = BillingPostalCode;
        app.Direccion__c = Calle + ', ' + BillingPostalCode + ', ' + BillingCity + ', ' + BillingState;
        app.Escuela_de_procedencia__c = Escueladeprocedenciac;
        app.Nivel_Escolar__c = ProgramaSelected.Nivel_de_estudio__c;
        app.hed__Applying_To__c = ProgramaSelected.Id;
        app.hed__Applicant__c = alu.Id;
        
                
        insert app;
        if(Test.isRunningTest()){
            return null;
        }
        
        return null;//new PageReference('https://www.umm.edu.mx/landings/il/gracias/');
    }
    
    public void SelectNivel(){
        System.debug('Se selecciono el nivel: ' + Tipodecarrerac);
        ResetLists();
        getProgramas(Tipodecarrerac);
    }
	
    public void SelectPrograma(){
		System.debug('Programa seleccionado: ' + Programac);
		programaSelected = [Select id, Nivel_de_estudio__c, Programa_largo__c, Modalidad__c, Sede__c, Site__c, Jornada__c from Account where Id =: Programac];
        if(programaSelected.Modalidad__c == 'PRESENCIAL'){
            esVirtual = false;
            getSede();
        }else{
            esVirtual = true;
            getSite();
        }
        getTurno();
        Programac = programaSelected.Id;
        Plazo = [SELECT Id FROM hed__Term__c WHERE hed__Account__c =: ProgramaSelected.Id];
        Modalidadc = programaSelected.Modalidad__c;
    }
	    
    public void getProgramas(String nivel){
        programas = new List<SelectOption>();
        List<Account> progs = [Select id, name, Programa_largo__c from Account Where Nivel_de_estudio__c =: nivel AND RecordtypeId =: ProgRTId];
        programas.add(new SelectOption('','--Selecciona un programa--'));
        if(progs.size()>0){
        	for(Account prog : progs){
            	programas.add(new SelectOption(prog.Id, prog.Programa_largo__c));
        	}
        }
    }
    
    public void getSede(){
        sedes = new List<SelectOption>();
        sedes.add(new SelectOption('','--Selecciona una sede--'));
        List<String> temp = new List<String>();
        temp.addAll(programaSelected.Sede__c.split(';'));
        System.debug(temp);
        for(String sede : temp){
            sedes.add(new SelectOption(sede,sede));
        }
    }
    
    public void getSite(){
        sites = new List<SelectOption>();
        sites.add(new SelectOption('','--Selecciona un site--'));
        List<String> temp = new List<String>();
        temp.addAll(programaSelected.Site__c.split(';'));
        System.debug(temp);
        for(String site : temp){
            sites.add(new SelectOption(site,site));
        }
    }
    
    public void getTurno(){
        turnos = new List<SelectOption>();
        turnos.add(new SelectOption('','--Selecciona un turno--'));
        List<String> temp = new List<String>();
        temp.addAll(programaSelected.Jornada__c.split(';'));
        System.debug(temp);
        for(String jornada : temp){
            turnos.add(new SelectOption(jornada,jornada));
        }
    }
    public void ResetLists(){
        sedes = new List<SelectOption>();
        sites = new List<SelectOption>();
        turnos = new List<SelectOption>();
        
        sedes.add(new SelectOption('','--Selecciona un programa--'));
        sites.add(new SelectOption('','--Selecciona un programa--'));
        turnos.add(new SelectOption('','--Selecciona un programa--'));
    }
}