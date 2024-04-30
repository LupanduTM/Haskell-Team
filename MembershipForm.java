public class MembershipForm {
    private String fullName;
    private String nrcNumber;
    private String email;
    private String phoneNumber;
    private boolean isPaid;

    // Constructor
    public MembershipForm(String fullName, String nrcNumber, String email, String phoneNumber) {
        this.fullName = fullName;
        this.nrcNumber = nrcNumber;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.isPaid = false; // Membership starts as unpaid
    }

    // Getter and setter methods for fullName
    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    //Getter and setter methods for nrcNumber
    public String getNrcNumber() {
        return nrcNumber;
    }

    public void setNrcNumber(String nrcNumber) {
        this.nrcNumber= nrcNumber;
    }
    // Getter and setter methods for email
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    // Getter and setter methods for phoneNumber
    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    // Getter and setter methods for isPaid
    public boolean isPaid() {
        return isPaid;
    }

    public void setPaid(boolean paid) {
        isPaid = paid;
    }

    // Method to mark membership as paid
    public void markAsPaid() {
        this.isPaid = true;
    }

    // Method to print membership details
    public void printDetails() {
        System.out.println("Name: " + fullName);
        System.out.println("NRC Number: " + nrcNumber);
        System.out.println("Email: " + email);
        System.out.println("Phone Number: " + phoneNumber);
        System.out.println("Membership Status: " + (isPaid ? "Paid" : "Unpaid"));
    }
}
