class BookingModel {
    int id;
    String createdDate;
    String modifiedDate;
    String createdUser;
    String modifiedUser;
    String bookingNo;
    DateTime bookingDate;
    String estimatedTime;
    int status;
    DateTime startDate;
    DateTime endDate;
    int autoAccept;
    String dayOfWeek;
    String startTime;
    String endTime;
    int maxPatientCount;
    int scheduleId;
    int scheduleDetailsId;
    int patientId;
    String patientPhoneNo;
    String patientName;
    String patientGender;
    int patientAge;
    int userId;
    String userPhoneNo;
    String userName;
    String userPhoto;
    int userType;
    int doctorId;
    String doctorSerialId;
    String doctorName;
    String doctorSama;
    String doctorDegree;
    String doctorPhoneNo;
    String doctorPhoto;
    String doctorProfilePhoto;
    int clinicId;
    String clinicNameEng;
    String clinicNameMyan;
    String clinicLogo;
    String clinicLatitude;
    String clinicLongitude;
    String clinicAddress;
    String clinicPhone;
    int clinicDoctorCount;
    int clinicUserCount;

    BookingModel({
        this.id,
        this.createdDate,
        this.modifiedDate,
        this.createdUser,
        this.modifiedUser,
        this.bookingNo,
        this.bookingDate,
        this.estimatedTime,
        this.status,
        this.startDate,
        this.endDate,
        this.autoAccept,
        this.dayOfWeek,
        this.startTime,
        this.endTime,
        this.maxPatientCount,
        this.scheduleId,
        this.scheduleDetailsId,
        this.patientId,
        this.patientPhoneNo,
        this.patientName,
        this.patientGender,
        this.patientAge,
        this.userId,
        this.userPhoneNo,
        this.userName,
        this.userPhoto,
        this.userType,
        this.doctorId,
        this.doctorSerialId,
        this.doctorName,
        this.doctorSama,
        this.doctorDegree,
        this.doctorPhoneNo,
        this.doctorPhoto,
        this.doctorProfilePhoto,
        this.clinicId,
        this.clinicNameEng,
        this.clinicNameMyan,
        this.clinicLogo,
        this.clinicLatitude,
        this.clinicLongitude,
        this.clinicAddress,
        this.clinicPhone,
        this.clinicDoctorCount,
        this.clinicUserCount,
    });

    factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
        id: json["id"],
        createdDate: json["createdDate"],
        modifiedDate: json["modifiedDate"],
        createdUser: json["createdUser"],
        modifiedUser: json["modifiedUser"],
        bookingNo: json["bookingNo"],
        bookingDate: DateTime.parse(json["bookingDate"]),
        estimatedTime: json["estimatedTime"],
        status: json["status"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        autoAccept: json["autoAccept"],
        dayOfWeek: json["dayOfWeek"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        maxPatientCount: json["maxPatientCount"],
        scheduleId: json["scheduleId"],
        scheduleDetailsId: json["scheduleDetailsId"],
        patientId: json["patientId"],
        patientPhoneNo: json["patientPhoneNo"],
        patientName: json["patientName"],
        patientGender: json["patientGender"],
        patientAge: json["patientAge"],
        userId: json["userId"],
        userPhoneNo: json["userPhoneNo"],
        userName: json["userName"],
        userPhoto: json["userPhoto"],
        userType: json["userType"],
        doctorId: json["doctorId"],
        doctorSerialId: json["doctorSerialId"],
        doctorName: json["doctorName"],
        doctorSama: json["doctorSama"],
        doctorDegree: json["doctorDegree"],
        doctorPhoneNo: json["doctorPhoneNo"],
        doctorPhoto: json["doctorPhoto"],
        doctorProfilePhoto: json["doctorProfilePhoto"],
        clinicId: json["clinicId"],
        clinicNameEng: json["clinicNameEng"],
        clinicNameMyan: json["clinicNameMyan"],
        clinicLogo: json["clinicLogo"],
        clinicLatitude: json["clinicLatitude"],
        clinicLongitude: json["clinicLongitude"],
        clinicAddress: json["clinicAddress"],
        clinicPhone: json["clinicPhone"],
        clinicDoctorCount: json["clinicDoctorCount"],
        clinicUserCount: json["clinicUserCount"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "createdDate": createdDate,
        "modifiedDate": modifiedDate,
        "createdUser": createdUser,
        "modifiedUser": modifiedUser,
        "bookingNo": bookingNo,
        "bookingDate": "${bookingDate.year.toString().padLeft(4, '0')}-${bookingDate.month.toString().padLeft(2, '0')}-${bookingDate.day.toString().padLeft(2, '0')}",
        "estimatedTime": estimatedTime,
        "status": status,
        "startDate": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "endDate": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "autoAccept": autoAccept,
        "dayOfWeek": dayOfWeek,
        "startTime": startTime,
        "endTime": endTime,
        "maxPatientCount": maxPatientCount,
        "scheduleId": scheduleId,
        "scheduleDetailsId": scheduleDetailsId,
        "patientId": patientId,
        "patientPhoneNo": patientPhoneNo,
        "patientName": patientName,
        "patientGender": patientGender,
        "patientAge": patientAge,
        "userId": userId,
        "userPhoneNo": userPhoneNo,
        "userName": userName,
        "userPhoto": userPhoto,
        "userType": userType,
        "doctorId": doctorId,
        "doctorSerialId": doctorSerialId,
        "doctorName": doctorName,
        "doctorSama": doctorSama,
        "doctorDegree": doctorDegree,
        "doctorPhoneNo": doctorPhoneNo,
        "doctorPhoto": doctorPhoto,
        "doctorProfilePhoto": doctorProfilePhoto,
        "clinicId": clinicId,
        "clinicNameEng": clinicNameEng,
        "clinicNameMyan": clinicNameMyan,
        "clinicLogo": clinicLogo,
        "clinicLatitude": clinicLatitude,
        "clinicLongitude": clinicLongitude,
        "clinicAddress": clinicAddress,
        "clinicPhone": clinicPhone,
        "clinicDoctorCount": clinicDoctorCount,
        "clinicUserCount": clinicUserCount,
    };
}