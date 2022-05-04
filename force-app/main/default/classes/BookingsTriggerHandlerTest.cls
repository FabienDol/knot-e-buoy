@IsTest
private class BookingsTriggerHandlerTest {

  @TestSetup
  static void makeData(){
    
  }

  @IsTest
  static void testUpdateBoatStatus_EndsInPast() {
    // GIVEN
    Account acc = new Account();
    acc.Name = 'ACC TEST';
    insert acc;
    Contact con = new Contact();
    con.AccountId = acc.Id;
    con.LastName = 'ACC NAME';
    insert con;
    Boat__c boat = new Boat__c();
    boat.Name = 'TEST BOAT';
    boat.Contact__c = con.Id;
    insert boat;
    Booking__c book = new Booking__c();
    book.Account__c = acc.Id;
    book.Customer_Contact__c = con.Id;
    book.Start_Date__c = Date.today().addDays(-1);
    book.End_Date__c = Date.today().addDays(5);
    book.Status__c = 'Option';
    book.Boat__c = boat.Id;
    insert book;

    List<Booking__c> bookings = new List<Booking__c>();
    bookings.add(book);

    // WHEN
    Test.startTest();
    BookingsTriggerHandler.updateBoatStatus(bookings);
    Test.stopTest();

    // THEN
    Boat__c boatAfter = [
      SELECT Id, Disponibilite__c
      FROM Boat__c
      WHERE Id = :boat.Id
      LIMIT 1
    ];
    System.assertEquals(
      'Disponible',
      boatAfter.Disponibilite__c,
      'Should be available'
    );
  }

  @IsTest
  static void testUpdateBoatStatus_StartsIn10Days() {
    // GIVEN
    Account acc = new Account();
    acc.Name = 'ACC TEST';
    insert acc;
    Contact con = new Contact();
    con.AccountId = acc.Id;
    con.LastName = 'ACC NAME';
    insert con;
    Boat__c boat = new Boat__c();
    boat.Name = 'TEST BOAT';
    boat.Contact__c = con.Id;
    insert boat;
    Booking__c book = new Booking__c();
    book.Account__c = acc.Id;
    book.Customer_Contact__c = con.Id;
    book.Start_Date__c = Date.today().addDays(10);
    book.End_Date__c = Date.today().addDays(15);
    book.Status__c = 'Option';
    book.Boat__c = boat.Id;
    insert book;

    List<Booking__c> bookings = new List<Booking__c>();
    bookings.add(book);

    // WHEN
    Test.startTest();
    BookingsTriggerHandler.updateBoatStatus(bookings);
    Test.stopTest();

    // THEN
    Boat__c boatAfter = [
      SELECT Id, Disponibilite__c
      FROM Boat__c
      WHERE Id = :boat.Id
      LIMIT 1
    ];
    System.assertEquals(
      'Disponible',
      boatAfter.Disponibilite__c,
      'Should be available'
    );
  }

  @IsTest
  static void testUpdateBoatStatus_StartsTomorrow() {
    // GIVEN
    Account acc = new Account();
    acc.Name = 'ACC TEST';
    insert acc;
    Contact con = new Contact();
    con.AccountId = acc.Id;
    con.LastName = 'ACC NAME';
    insert con;
    Boat__c boat = new Boat__c();
    boat.Name = 'TEST BOAT';
    boat.Contact__c = con.Id;
    insert boat;
    Booking__c book = new Booking__c();
    book.Account__c = acc.Id;
    book.Customer_Contact__c = con.Id;
    book.Start_Date__c = Date.today().addDays(1);
    book.End_Date__c = Date.today().addDays(5);
    book.Status__c = 'Option';
    book.Boat__c = boat.Id;
    insert book;

    List<Booking__c> bookings = new List<Booking__c>();
    bookings.add(book);

    // WHEN
    Test.startTest();
    BookingsTriggerHandler.updateBoatStatus(bookings);
    Test.stopTest();

    // THEN
    Boat__c boatAfter = [
      SELECT Id, Disponibilite__c
      FROM Boat__c
      WHERE Id = :boat.Id
      LIMIT 1
    ];
    System.assertEquals(
      'Indisponible',
      boatAfter.Disponibilite__c,
      'Should be unavailable'
    );
  }
}
