public with sharing class BookingsTriggerHandler {
    public static void onAfterInsert(List<Booking__c> bookings) {

        updateBoatStatus(bookings);

    }

    public static void updateBoatStatus(List<Booking__c> bookings) {

        // liste à remplir dans la boucle puis passer au DML à la fin
        List<Boat__c> boats = new List<Boat__c>();

        for (Booking__c booking : bookings) {

            Id boatId = booking.Boat__c;

            if (boatId != null) {
                    
                if (booking.Start_Date__c <= Date.today().addDays(3) && booking.End_Date__c > Date.today()) {

                    // constructeur avec Id renseigné + DML update = OK pour update
                    Boat__c boatToUpdate = new Boat__c(Id = boatId, Disponibilite__c = 'Indisponible');
                    boats.add(boatToUpdate);

                } else {
                    Boat__c boatToUpdate = new Boat__c(Id = boatId, Disponibilite__c = 'Disponible');
                    boats.add(boatToUpdate);
                }

            }
        }

        update boats;
    }
}
