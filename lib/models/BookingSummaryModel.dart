class BookingSummaryModel {
    int acceptCount;
    int rejectCount;
    int totalCount;
    int pendingCount;

    BookingSummaryModel({
        this.acceptCount,
        this.rejectCount,
        this.totalCount,
        this.pendingCount,
    });

    factory BookingSummaryModel.fromJson(Map<String, dynamic> json) => BookingSummaryModel(
        acceptCount: json["acceptCount"],
        rejectCount: json["rejectCount"],
        totalCount: json["totalCount"],
        pendingCount: json["pendingCount"],
    );

    Map<String, dynamic> toJson() => {
        "acceptCount": acceptCount,
        "rejectCount": rejectCount,
        "totalCount": totalCount,
        "pendingCount": pendingCount,
    };
}