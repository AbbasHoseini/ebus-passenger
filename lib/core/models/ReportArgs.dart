class ReportArgs {
  int? reportId, travelId;
  String? title,
      description,
      destination,
      travelDate,
      travelTime,
      createDate,
      createTime,
      source;

  ReportArgs(
      {this.reportId,
      this.title,
      this.description,
      this.source,
      this.destination,
      this.travelDate,
      this.travelTime,
      this.createDate,
      this.createTime,
      this.travelId});
}
