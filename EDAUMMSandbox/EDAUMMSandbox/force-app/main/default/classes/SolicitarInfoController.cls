public class SolicitarInfoController {
	public Account Household {get;set;}
    public Contact alu {get;set;}
    public Account prog {get;set;}
    public Opportunity opp {get;set;}
    public String Nivel_de_Estudio {get;set;}
    public String Area_de_Estudio {get;set;}
    public String formModalidad {get;set;}
    public String formSede {get;set;}
    public String formSite {get;set;}
    public String source {get;set;}
    public List<Account> allProgramas {get;set;} 
    public String jsonProgramas {get;set;}
    public String baseURL {get;set;}
    public Id ProgRTId {get;set;}
    public SelectOption formPrograma {get;set;}
    
    public SolicitarInfoController() {
        alu = new Contact();
        prog = new Account();
        opp = new Opportunity();
        ProgRTId =  Schema.SObjectType.Account.getRecordTypeInfosByName().get('Academic Program').getRecordTypeId();
        allProgramas = [SELECT Name, Nivel_de_estudio__c, Modalidad__c, Programa_largo__c FROM Account WHERE RecordTypeId =: ProgRTId];
        jsonProgramas= JSON.serialize(allProgramas);
    }
        
    public PageReference saveAccount() {

        PageReference pageRef = null;
        String UTMSource = apexpages.currentpage().getparameters().get('utm_source');
        String UTMMedium = apexpages.currentpage().getparameters().get('utm_medium');
        String UTMCampaign = apexpages.currentpage().getparameters().get('utm_campaign');
        System.debug('UTM_source: ' + UTMSource);
        System.debug('UTM_medium: ' + UTMMedium);
        System.debug('UTM_campaign: ' + UTMCampaign);
        	try{
                System.debug('Starting saving account');
                ////PROCESO DE ADMISION
                String nivelEstudioParam = prog.Nivel_de_estudio__c;
                system.debug('prog.Nivel_de_Estudio__c = '+prog.Nivel_de_estudio__c);
                String tipoCarrera = '';
                String tipoCarreraFront = '';
                String programaId = formPrograma.getValue();
                Date hoy = System.today();
                Account objetoPrograma = [SELECT Id, Name, Programa_largo__c, Esquema__c FROM Account WHERE Id = :programaId LIMIT 1];
                hed__Term__c objetoPlazo = [Select Id FROM hed__Term__c WHERE hed__Start_Date__c <= :hoy AND hed__End_Date__c >= :hoy AND hed__Account__c =: objetoPrograma.Id];
                if(nivelEstudioParam == 'Posgrado'){
                    tipoCarrera = 'POSGRADO';
                    tipoCarreraFront = 'MAESTRÍA';
                }else if(nivelEstudioParam == 'Prepa UMM'){
                    tipoCarrera = 'BACHILLERATO'; tipoCarreraFront = 'LICENCIATURA';
                }else if(nivelEstudioParam == 'Profesional'){
                    tipoCarrera = 'PREGRADO'; tipoCarreraFront = 'LICENCIATURA';
                }
                
                opp.StageName = 'Interesado';
                //opp.Tipo_de_Programa__c = tipoCarrera;
                opp.SubEtapa__c = 'Por llenar formulario';
                opp.Name = alu.Name + ' - ' + objetoPrograma.Name;
                opp.CloseDate = System.today() + 30;
                opp.Programa__c = objetoPrograma.Id;
                opp.Periodo__c = objetoPlazo.Id;
                               
                //CONSULTAR SI EXISTE UN CONTACT CON EL MISMO CORREO
                String email = alu.Email; 
                Integer emailCount = 0;
                List<Contact> contactossMismoEmail = [SELECT Id, Email FROM Contact WHERE Email = :email];
                System.debug('Correo '+email+' size = '+contactossMismoEmail.size() );
                
                //SI EL CONTACT EXISTE
                if(contactossMismoEmail.size() > 0){
                    for(Contact contacto : contactossMismoEmail){
                        System.debug('Account ya existe: '+contacto.Id);
                        opp.ContactId = contacto.Id;
                        
                        //CONSULTAR LOS PROCESOS DE ADMISION DE ESTE ACCOUNT
                        List<Opportunity> oppsActuales = [SELECT Id FROM Opportunity WHERE ContactId = :contacto.Id];
                        //SI EL PROCESO DE ADMISION EXISTE
                		if(oppsActuales.size() > 0){
                            for(Opportunity oportunidad : oppsActuales){
                                System.debug('Proceso de Admisión ya existe: '+oportunidad.Id);
                                //detalleProcesoAdmision.Opportunity = proceso.Id;
                                                                
                            }
                        }
                        else{
                            system.debug('Insertando el nuevo proceso de admisión: procesoAdmision.Alumno__c = ' + opp.ContactId);
                            opp.Id = null;
                            system.debug('Insertando el nuevo proceso de admisión: procesoAdmision.Id = ' + opp.Id);
                        	insert opp;                            
                        }
                    }
                }else{
                    
                    System.debug('proceso solo');                    
                    insert alu;
                	opp.ContactId = alu.Id;
                	insert opp;
                }
                //Setear la url de acuerdo al host de la página
                system.debug('baseURL = ' + baseURL);
                if( baseURL != null && baseURL.contains('programas.umm.edu.mx') ){
                 	pageRef = new PageReference('https://programas.umm.edu.mx/gracias/');
                }
                else if( baseURL != null && baseURL.contains('https://onissolutions.net') ){
                    pageRef = new PageReference('https://www.onissolutions.net/');
                }
                else{
                	pageRef = new PageReference('https://www.umm.edu.mx/');    
                }
            } catch(Exception e) {
                System.debug('excepcion' +e.getLineNumber());
                System.debug('Exception: '+e);
                ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'Error al guardar tu información, intenta de nuevo más tarde. Excepcion: '+e));
                //ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'Excepcion '+e));
            }
        System.debug('Finishing saving account'+pageRef);
        return pageRef;
    }
    
    public List<SelectOption> getNiveldeEstudio() {
        List<SelectOption> niveles = new List<SelectOption>();
        String programa;
        try{
            programa = ApexPages.currentPage().getParameters().get('j_id0:j_id2:formulario:programa');
            system.debug(programa);
            List<sObject> records;
            Date hoy = System.today();
        	DateTime hoyDT = dateTime.newInstance(hoy, Time.newInstance(0, 0, 0, 0));
            String query = 'SELECT Id, Nivel_de_estudio__c FROM Account WHERE id = \''+ programa+'\'';
            system.debug(query);
            records = Database.query(query);
            system.debug(query);
            
            /*for(integer i=0;i<records.size();i++){
                for (String fieldName : records[i].getPopulatedFieldsAsMap().keySet()){
                    if(fieldName != 'Id' && fieldName != 'Periodo__c'){
                        String val = records[i].getPopulatedFieldsAsMap().get(fieldName)+'';
                        if(val == 'POSGRADO'){
                            niveles.add(new SelectOption('Posgrado','Posgrado'));
                        }else if(val == 'BACHILLERATO'){
                            niveles.add(new SelectOption('Prepa UMM','Prepa UMM'));
                        }else if(val == 'PREGRADO'){
                            niveles.add(new SelectOption('Profesional','Profesional'));
                        }
                    }
				}
            }*/
        }catch(Exception e){
            niveles.add(new SelectOption('--None--','--Nivel de Estudio--'));
            system.debug(programa);
            Schema.Describefieldresult result = Schema.sObjectType.Account.fields.Nivel_de_estudio__c;
            result = result.getSObjectField().getDescribe();
            List<Schema.PicklistEntry> nvls = result.getPicklistValues();
            Integer contNiveles = 0;
            for( Schema.PicklistEntry n : nvls)
            {
                if(contNiveles >= 3){
                    break;
                }
                System.debug(n.getLabel());
                System.debug(n.getValue());
                niveles.add(new SelectOption(n.getLabel(), n.getValue()));
                contNiveles++;
            } 
        }
        
        system.debug(niveles);
        return niveles;
    }
    
    public List<SelectOption> getProgramas() {
        System.debug('Programa: ' + prog);
        String nivelEstudioParam = ApexPages.currentPage().getParameters().get('j_id0:j_id2:formulario:nivelDeEstudio');
        system.debug(nivelEstudioParam);
        String modalidad = ApexPages.currentPage().getParameters().get('j_id0:j_id2:formulario:modalidad');
        system.debug(modalidad);
        String areaEstudio = ApexPages.currentPage().getParameters().get('j_id0:j_id2:formulario:areaDeEstudio');
        system.debug(areaEstudio);
        String condicion = '';
        /*if(nivelEstudioParam == 'Posgrado'){
            nivelEstudioParam = 'POSGRADO';
        }else if(nivelEstudioParam == 'Prepa UMM'){
            nivelEstudioParam = 'BACHILLERATO';
        }else if(nivelEstudioParam == 'Profesional'){
            nivelEstudioParam = 'PREGRADO';
        }*/
        
        List<String> parametros = new List<String>();
        parametros.add(' Nivel_de_estudio__c = \''+nivelEstudioParam+'\'');
        parametros.add(' Modalidad__c = \''+modalidad+'\'');
        parametros.add(' Area_de_Estudio__c = \''+areaEstudio+'\'');
        
        system.debug(parametros);
        
        for(integer i=0;i<parametros.size();i++){
            system.debug(parametros[i]);
        	if(parametros[i].contains('--None--')){
            	
        	}
            else if(parametros[i].contains('null')){
                
            }
            else {
            	condicion = condicion + ' AND '+parametros[i];
        	}
        }
        
        system.debug(condicion);
        
        List<SelectOption> programas = new List<SelectOption>();
        programas.add(new SelectOption('--None--','--Programa--'));
        
        Date hoy = System.today();
        List<hed__Term__c> plazos = [Select id, hed__Account__c from hed__Term__c where hed__Start_Date__c <= : hoy  AND hed__End_Date__c >= : hoy];
        List<Id> idProgs = new List<Id>();
        for(hed__Term__c plazo : plazos){
            idProgs.add(plazo.hed__Account__c);
        }
        String query = 'SELECT Id, Programa_largo__c  FROM Account WHERE Id in :idProgs';
        if(condicion != ''){
        	query += condicion ;
        }
        
        List<Account> results = new List<Account>();
        system.debug(query);
        results = Database.query(query);
        system.debug(query);
        System.debug('resultados de query******** '+ results);
        for(Account programa: results){
            system.debug(programa.get('Programa_largo__c'));
            SelectOption prg = new SelectOption(String.valueOf(programa.get('Id')),String.valueOf(programa.get('Programa_largo__c')));
            programas.add(prg);
        }
        
		return programas;
  	}
    
    public List<SelectOption> getAreadeEstudio() {
        List<SelectOption> areas = new List<SelectOption>();
        String programa;
        try{
            programa = ApexPages.currentPage().getParameters().get('j_id0:j_id2:formulario:programa');
            system.debug(programa);
            List<sObject> records;
            Date hoy = System.today();
        	DateTime hoyDT = dateTime.newInstance(hoy, Time.newInstance(0, 0, 0, 0));
            String query = 'SELECT Id, Area_de_Estudio__c FROM Account WHERE Id = \''+ formPrograma.getValue() +'\'';
            system.debug(query);
            records = Database.query(query);
            system.debug(query);
            
            /*for(integer i=0;i<records.size();i++){
                for (String fieldName : records[i].getPopulatedFieldsAsMap().keySet()){
                    if(fieldName != 'Id' && fieldName != 'Periodo__c'){
                        areas.add(new SelectOption(records[i].getPopulatedFieldsAsMap().get(fieldName)+'',records[i].getPopulatedFieldsAsMap().get(fieldName)+''));
                    }
                }
            }*/
        }catch(Exception e){
            areas.add(new SelectOption('--None--','--Área de Estudio--'));
            
            Schema.Describefieldresult result = Schema.sObjectType.Account.fields.Area_de_Estudio__c;
            result = result.getSObjectField().getDescribe();
            List<Schema.PicklistEntry> ars = result.getPicklistValues();
            
            for( Schema.PicklistEntry a : ars)
            {
                areas.add(new SelectOption(a.getLabel(), a.getValue()));
            }  
        }
        
        system.debug(areas);
        return areas;
    }
    
    public List<SelectOption> getModalidades() {
        List<SelectOption> modalidades = new List<SelectOption>();
        String programa;
        try{
            programa = ApexPages.currentPage().getParameters().get('j_id0:j_id2:formulario:programa');
            system.debug(programa);
            List<sObject> records;
            Date hoy = System.today();
        	DateTime hoyDT = dateTime.newInstance(hoy, Time.newInstance(0, 0, 0, 0));
            String query = 'SELECT Id, Modalidad__c FROM Programa__c WHERE Id = \''+ formPrograma.getValue() +'\'';
            system.debug(query);
            records = Database.query(query);
            system.debug(query);
            
            /*for(integer i=0;i<records.size();i++){
                for (String fieldName : records[i].getPopulatedFieldsAsMap().keySet()){
                    if(fieldName != 'Id' && fieldName != 'Periodo__c'){
                        modalidades.add(new SelectOption(records[i].getPopulatedFieldsAsMap().get(fieldName)+'',records[i].getPopulatedFieldsAsMap().get(fieldName)+''));
                    }
                }
            }*/
        }catch(Exception e){
            modalidades.add(new SelectOption('--None--','--Modalidad--'));
            
            Schema.Describefieldresult result = Schema.sObjectType.Account.fields.Modalidad__c;
            result = result.getSObjectField().getDescribe();
            List<Schema.PicklistEntry> mods = result.getPicklistValues();
            
            for( Schema.PicklistEntry m : mods)
            {
                modalidades.add(new SelectOption(m.getLabel(), m.getValue()));
            }
        }
        
        system.debug(modalidades);
        return modalidades;
    }
    
    public List<SelectOption> getSedes() {
        List<SelectOption> sedes = new List<SelectOption>();
        sedes.add(new SelectOption('--None--','--Sede--'));
        String programa;
        try{
            programa = ApexPages.currentPage().getParameters().get('j_id0:j_id2:formulario:programa');
            system.debug('sede-programa = '+programa);
            List<sObject> records;
            Date hoy = System.today();
        	DateTime hoyDT = dateTime.newInstance(hoy, Time.newInstance(0, 0, 0, 0));
            String query = 'SELECT Id, Sede__c FROM Account WHERE Id = \''+ programa +'\'';
            system.debug('sede-query = '+query);
            records = Database.query(query);
            system.debug('sede-records = '+ records);
            
            for(integer i=0;i<records.size();i++){
                for (String fieldName : records[i].getPopulatedFieldsAsMap().keySet()){
                    System.debug('fieldName ' + fieldName);
                    if(fieldName != 'Id' && fieldName != 'RecordTypeId'){
                        String val = records[i].getPopulatedFieldsAsMap().get(fieldName)+'';
                        System.debug('val: ' + val);
                        if(val.Contains(';')){
                            String[] vals = val.split(';');
                            system.debug(vals);
                            for(integer h=0;h<vals.size();h++){
                                sedes.add(new SelectOption(vals[h],vals[h]));
                            }
                        }
                        else{
                            sedes.add(new SelectOption(records[i].getPopulatedFieldsAsMap().get(fieldName)+'',records[i].getPopulatedFieldsAsMap().get(fieldName)+''));
                        }
                    }
                }
            }
        }catch(Exception e){
            Schema.Describefieldresult result = Schema.sObjectType.Account.fields.Sede__c;
            result = result.getSObjectField().getDescribe();
            List<Schema.PicklistEntry> seds = result.getPicklistValues();
            
            for( Schema.PicklistEntry s : seds)
            {
                sedes.add(new SelectOption(s.getLabel(), s.getValue()));
            }
        }

        system.debug('sede-lista = '+sedes);
        
        return sedes;
    }
    public List<SelectOption> getSite() {
        List<SelectOption> Sites = new List<SelectOption>();
        try{
            String programa = ApexPages.currentPage().getParameters().get('j_id0:j_id2:formulario:programa');
            String modalidad = ApexPages.currentPage().getParameters().get('j_id0:j_id2:formulario:modalidad');
            if(modalidad == 'PRESENCIAL' || modalidad == 'VIRTUAL' || programa == null)
                        Sites.add(new SelectOption('--None--','--Site--'));
            List<sObject> records;
            Date hoy = System.today();
        	DateTime hoyDT = dateTime.newInstance(hoy, Time.newInstance(0, 0, 0, 0));
            String query = 'SELECT Id, Site__c FROM Account WHERE Id = \''+ programa +'\'';
            system.debug('sede-query = '+query);
            records = Database.query(query);
            system.debug('sede-query = '+query);
            
            for(integer i=0;i<records.size();i++){
                for (String fieldName : records[i].getPopulatedFieldsAsMap().keySet()){
                    if(fieldName != 'Id' && fieldName != 'RecordTypeId'){
                        String val = records[i].getPopulatedFieldsAsMap().get(fieldName)+'';
                        if(val.Contains(';')){
                            String[] vals = val.split(';');
                            system.debug(vals);
                            for(integer h=0;h<vals.size();h++){
                                Sites.add(new SelectOption(vals[h],vals[h]));
                            }
                        }
                        else{
                            Sites.add(new SelectOption(records[i].getPopulatedFieldsAsMap().get(fieldName)+'',records[i].getPopulatedFieldsAsMap().get(fieldName)+''));
                        }
                    }
                }
            }
        system.debug(programa);
        }catch(Exception e){
            Schema.Describefieldresult result = Schema.sObjectType.Account.fields.Site__c;
            result = result.getSObjectField().getDescribe();
            List<Schema.PicklistEntry> sits = result.getPicklistValues();
            
            for( Schema.PicklistEntry s : sits)
            {
                Sites.add(new SelectOption(s.getLabel(), s.getValue()));
            }
        }
        
        system.debug(Sites);
        return Sites;
    }
}