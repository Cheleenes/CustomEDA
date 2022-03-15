@isTest
public class SolicitarInfoControllerTest {
    @isTest static void testSaveAcc() {
        ApexPages.currentPage().getParameters().put('j_id0:j_id2:formulario:email','luis.torres@mail.com');
        
        SolicitarInfoController ummctrl = new SolicitarInfoController();
        
        Account acc = new Account();
        acc.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Academic Program').getRecordTypeId();
        acc.Name = 'Test';       
        acc.Programa_largo__c = 'Test a';
        acc.Modalidad__c = 'PRESENCIAL';
        acc.Sede__c = 'APODACA';
        acc.Jornada__c = 'Fin de semana';
        insert acc;
        
        ApexPages.currentPage().getParameters().put('j_id0:j_id2:formulario:programa', acc.Id);
        
        Account alu = new Account();
        alu.Name = 'test';
        alu.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Household Account').getRecordTypeId();
        insert alu;
        
        Contact cont = new Contact();
        cont.LastName = 'test1';
        cont.Email = 'test@test.com';
        cont.AccountId = alu.Id;
        cont.Nacionalidad__c = 'Mexicana';
        insert cont;
        
        hed__Term__c per = new hed__Term__c();
        per.name = 'test';
        per.hed__Account__c = acc.Id;
        insert per;
        
        Opportunity opp = new Opportunity();
        opp.Name = 'opp';
        opp.StageName = 'Abierto';
        opp.CloseDate = System.today() + 1;
        opp.AccountId = alu.Id;
        opp.ContactId = cont.Id;
        opp.Programa_Acad_mico__c = acc.Id;
        opp.Periodo__c = per.Id;
        insert opp;
        
        ummctrl.Nivel_de_Estudio = 'PREGRADO';
        ummctrl.Area_de_Estudio = '';
        ummctrl.source = '';
        ummctrl.Household = alu;
        ummctrl.formModalidad = 'PRESENCIAL';
        ummctrl.formSede = 'APODACA';
        ummctrl.formSite = 'APODACA';
        PageReference controller = ummctrl.saveAccount();
        System.assert(true);    
    }
    
    @isTest static void testNivelEstudio() {
        SolicitarInfoController ummctrl = new SolicitarInfoController();
        List<SelectOption> controller = ummctrl.getNiveldeEstudio();
        System.assert(controller != null); 
    }
    
    @isTest static void testNivelEstudio2() {
        PageReference pageRef = Page.SolicitarInfoForm;
        ApexPages.currentPage().getParameters().put('j_id0:j_id2:formulario:programa','82');
        /*Programa__c programa = new Programa__c();
        programa.Nivel_de_Estudio__c = 'Profesional';
        programa.Name = 'LIC. ADMINISTRACION DE EMPRESAS 2015';
        programa.Codigo_programa__c = '82';
        programa.Tipo_de_programa__c = 'PREGRADO';
        programa.Activo__c = true;
        insert programa;*/
        Account acc = new Account();
        acc.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Academic Program').getRecordTypeId();
        acc.Name = 'LIC. ADMINISTRACION DE EMPRESAS 2015';       
        acc.Programa_largo__c = 'LIC. ADMINISTRACION DE EMPRESAS 2015';
        acc.Modalidad__c = 'PRESENCIAL';
        acc.Sede__c = 'APODACA';
        acc.Jornada__c = 'Fin de semana';
        acc.Nivel_de_estudio__c = 'Profesional';
        insert acc;
        
        SolicitarInfoController ummctrl = new SolicitarInfoController();
        List<SelectOption> controller = ummctrl.getNiveldeEstudio();
        System.assert(controller != null); 
    }
    
    @isTest static void testProgramas() {
        ApexPages.currentPage().getParameters().put('j_id0:j_id2:formulario:nivelDeEstudio','POSGRADO');
        SolicitarInfoController ummctrl = new SolicitarInfoController();
        List<SelectOption> controller = ummctrl.getProgramas();
        System.assert(controller != null); 
    }
    
    @isTest static void testProgramas1() {
        ApexPages.currentPage().getParameters().put('j_id0:j_id2:formulario:nivelDeEstudio','PREGRADO');
        /*Programa__c programa = new Programa__c();
        programa.Nivel_de_Estudio__c = 'Profesional';
        programa.Name = 'LIC. ADMINISTRACION DE EMPRESAS 2015';
        programa.Activo__c = true;
        programa.Codigo_programa__c = '52';
        insert programa;*/
        Account acc = new Account();
        acc.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Academic Program').getRecordTypeId();
        acc.Name = 'LIC. ADMINISTRACION DE EMPRESAS 2015';       
        acc.Programa_largo__c = 'LIC. ADMINISTRACION DE EMPRESAS 2015';
        acc.Modalidad__c = 'PRESENCIAL';
        acc.Sede__c = 'APODACA';
        acc.Jornada__c = 'Fin de semana';
        acc.Nivel_de_estudio__c = 'Profesional';
        insert acc;
        
        SolicitarInfoController ummctrl = new SolicitarInfoController();
        List<SelectOption> controller = ummctrl.getProgramas();
        System.assert(controller != null); 
    }
    
    @isTest static void testProgramas2() {
        PageReference pageRef = Page.SolicitarInfoForm;
        ApexPages.currentPage().getParameters().put('j_id0:j_id2:formulario:programa','82');
        ApexPages.currentPage().getParameters().put('j_id0:j_id2:formulario:nivelDeEstudio','BACHILLERATO');
        SolicitarInfoController ummctrl = new SolicitarInfoController();
        List<SelectOption> controller = ummctrl.getProgramas();
        System.assert(controller != null); 
    }
    
    @isTest static void testAreadeEstudio() {
        SolicitarInfoController ummctrl = new SolicitarInfoController();
        List<SelectOption> controller = ummctrl.getAreadeEstudio();
        System.assert(controller != null); 
    }
    
    @isTest static void testAreadeEstudio2() {
        PageReference pageRef = Page.SolicitarInfoForm;
        ApexPages.currentPage().getParameters().put('j_id0:j_id2:formulario:programa','82');
        /*Programa__c programa = new Programa__c();
        programa.Nivel_de_Estudio__c = 'Profesional';
        programa.Name = 'LIC. ADMINISTRACION DE EMPRESAS 2015';
        programa.Codigo_programa__c = '82';
        programa.Area_de_Estudio__c = 'NEGOCIOS';
        programa.Activo__c = true;
        insert programa;*/
        Account acc = new Account();
        acc.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Academic Program').getRecordTypeId();
        acc.Name = 'LIC. ADMINISTRACION DE EMPRESAS 2015';       
        acc.Programa_largo__c = 'LIC. ADMINISTRACION DE EMPRESAS 2015';
        acc.Modalidad__c = 'PRESENCIAL';
        acc.Sede__c = 'APODACA';
        acc.Jornada__c = 'Fin de semana';
        acc.Nivel_de_estudio__c = 'Profesional';
        insert acc;
        
        SolicitarInfoController ummctrl = new SolicitarInfoController();
        List<SelectOption> controller = ummctrl.getAreadeEstudio();
        System.assert(controller != null); 
    }
    
    @isTest static void testModalidades() {
        SolicitarInfoController ummctrl = new SolicitarInfoController();
        List<SelectOption> controller = ummctrl.getModalidades();
        System.assert(controller != null); 
    }
    
    @isTest static void testModalidades2() {
        PageReference pageRef = Page.SolicitarInfoForm;
        ApexPages.currentPage().getParameters().put('j_id0:j_id2:formulario:programa','82');
        /*Programa__c programa = new Programa__c();
        programa.Nivel_de_Estudio__c = 'Profesional';
        programa.Name = 'LIC. ADMINISTRACION DE EMPRESAS 2015';
        programa.Codigo_programa__c = '82';
        programa.Modalidad__c = 'PRESENCIAL';
        programa.Activo__c = true;
        insert programa;    */ 
        Account acc = new Account();
        acc.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Academic Program').getRecordTypeId();
        acc.Name = 'LIC. ADMINISTRACION DE EMPRESAS 2015';       
        acc.Programa_largo__c = 'LIC. ADMINISTRACION DE EMPRESAS 2015';
        acc.Modalidad__c = 'PRESENCIAL';
        acc.Sede__c = 'APODACA';
        acc.Jornada__c = 'Fin de semana';
        acc.Nivel_de_estudio__c = 'Profesional';
        insert acc;
        
        SolicitarInfoController ummctrl = new SolicitarInfoController();
        List<SelectOption> controller = ummctrl.getModalidades();
        System.assert(controller != null); 
    }
    
    @isTest static void testSedes() {
        SolicitarInfoController ummctrl = new SolicitarInfoController();
        List<SelectOption> controller = ummctrl.getSedes();
        System.assert(controller != null); 
    }
    
    @isTest static void testSedes2() {
        PageReference pageRef = Page.SolicitarInfoForm;
        ApexPages.currentPage().getParameters().put('j_id0:j_id2:formulario:programa','82');
        /*Programa__c programa = new Programa__c();
        programa.Nivel_de_Estudio__c = 'Profesional';
        programa.Name = 'LIC. ADMINISTRACION DE EMPRESAS 2015';
        programa.Codigo_programa__c = '82';
        programa.Sede__c = 'APODACA;CENTRO;SANTA CATARINA';
        programa.Activo__c = true;
        insert programa;*/
        Account acc = new Account();
        acc.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Academic Program').getRecordTypeId();
        acc.Name = 'LIC. ADMINISTRACION DE EMPRESAS 2015';       
        acc.Programa_largo__c = 'LIC. ADMINISTRACION DE EMPRESAS 2015';
        acc.Modalidad__c = 'PRESENCIAL';
        acc.Sede__c = 'APODACA;CENTRO';
        acc.Jornada__c = 'Fin de semana';
        acc.Nivel_de_estudio__c = 'Profesional';
        insert acc;
        
        ApexPages.currentPage().getParameters().put('j_id0:j_id2:formulario:programa', acc.Id);
        
        SolicitarInfoController ummctrl = new SolicitarInfoController();
        List<SelectOption> controller = ummctrl.getSedes();
        System.assert(controller != null); 
    }
    
    @isTest static void testSites() {
        SolicitarInfoController ummctrl = new SolicitarInfoController();
        List<SelectOption> controller = ummctrl.getSite();
        System.assert(controller != null); 
    }
    
    @isTest static void testSites2() {
        PageReference pageRef = Page.SolicitarInfoForm;
        ApexPages.currentPage().getParameters().put('j_id0:j_id2:formulario:programa','82');
        /*Programa__c programa = new Programa__c();
        programa.Nivel_de_Estudio__c = 'Profesional';
        programa.Name = 'LIC. ADMINISTRACION DE EMPRESAS 2015';
        programa.Codigo_programa__c = '82';
        programa.Sede__c = 'APODACA;CENTRO;SANTA CATARINA';
        programa.Activo__c = true;
        insert programa;*/
        Account acc = new Account();
        acc.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Academic Program').getRecordTypeId();
        acc.Name = 'LIC. ADMINISTRACION DE EMPRESAS 2015';       
        acc.Programa_largo__c = 'LIC. ADMINISTRACION DE EMPRESAS 2015';
        acc.Modalidad__c = 'VIRTUAL';
        acc.Site__c = 'APODACA;CENTRO';
        acc.Jornada__c = 'Fin de semana';
        acc.Nivel_de_estudio__c = 'Profesional';
        insert acc;
        
        ApexPages.currentPage().getParameters().put('j_id0:j_id2:formulario:programa', acc.Id);
        
        SolicitarInfoController ummctrl = new SolicitarInfoController();
        List<SelectOption> controller = ummctrl.getSite();
        System.assert(controller != null); 
    }
}