class BookingDoctorDetailModel {
    int totalCount;
    int pendingCount;
    int rejectCount;
    int doctorId;
    String doctorName;
    int acceptCount;
    int maxPatientCount;

    BookingDoctorDetailModel({
        this.totalCount,
        this.pendingCount,
        this.rejectCount,
        this.doctorId,
        this.doctorName,
        this.acceptCount,
        this.maxPatientCount
    });

    factory BookingDoctorDetailModel.fromJson(Map<String, dynamic> json) => BookingDoctorDetailModel(
        totalCount: json["totalCount"],
        pendingCount: json["pendingCount"],
        rejectCount: json["rejectCount"],
        doctorId: json["doctorId"],
        doctorName: json["doctorName"],
        acceptCount: json["acceptCount"],
        maxPatientCount: json["maxPatientCount"]
    );

    Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "pendingCount": pendingCount,
        "rejectCount": rejectCount,
        "doctorId": doctorId,
        "doctorName": doctorName,
        "acceptCount": acceptCount,
        "maxPatientCount":maxPatientCount
    };
}