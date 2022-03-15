@IsTest
public class InscripcionesFormControllerTest {
	@IsTest public static void testInscripcion(){
        Account acc = new Account();
        acc.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Academic Program').getRecordTypeId();
        acc.Name = 'Test';       
        acc.Programa_largo__c = 'Test a';
        acc.Modalidad__c = 'PRESENCIAL';
        acc.Sede__c = 'APODACA';
        acc.Jornada__c = 'Fin de semana';
        insert acc;
        
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
        
        
        
        Test.startTest();
        
        Test.setCurrentPageReference(new PageReference('Page.InscripcionesForm')); 
        System.currentPageReference().getParameters().put('id', opp.Id);
        InscripcionesFormController FP = new InscripcionesFormController();
        FP.ApellidoPaterno = 'test';
        FP.ApellidoMAterno = 'test';
        FP.DiaNacimiento = '1';
        FP.MesNacimiento = '1';
        FP.AnoNacimiento = '1995';
        FP.Nombredeltutorc = 'test';
        FP.Emaildeltutorc = 'test@test.com';
        FP.Telefonodeltutorc = '8';
        FP.PersonMobilePhone = '8';
        FP.PersonEmail = 'test@test.com';
        FP.Nacionalidadc = 'Mexicana';
        FP.CURPc = 'test';
        FP.EstadoCivilc = 'casado';
        FP.PersonBirthdate = Date.newInstance(2000, 12, 9);
        FP.Calle = 'test';
        FP.BillingCity = 'test';
        FP.BillingState = 'test';
        FP.BillingPostalCode = 'test';
        FP.Escueladeprocedenciac = 'test';
        
        FP.Tipodecarrerac = 'Prepa UMM';
    	FP.Programac = acc.Id;
    	FP.Sedec = 'APODACA';
    	FP.Sitec = '';
   		FP.Jornadac = 'MATUTINO';
    	FP.Aceptterminosc = 'true';
        
        FP.Registrar();
        FP.ResetLists();
        
        Test.stopTest();
    }
}