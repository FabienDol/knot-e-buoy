trigger Bookings on Booking__c (after insert) {

    if (Trigger.isAfter) {
        if (Trigger.isInsert) {

          BookingsTriggerHandler.onAfterInsert(Trigger.new);

        }
    }
}