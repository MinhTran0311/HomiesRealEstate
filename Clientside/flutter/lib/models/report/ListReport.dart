class yearReport{
  int soBaiDang;
  double soTienNap;
  double soTienChi;
  int thangGhiNhan;
  int namGhiNhan;


  yearReport({
    this.soBaiDang,
    this.soTienNap,
    this.soTienChi,
    this.thangGhiNhan,
    this.namGhiNhan,
  });

  factory yearReport.fromMap(Map<String, dynamic> json) {
    return yearReport(
        soBaiDang: json["soBaiDang"],
        soTienNap: json["soTienNap"],
        soTienChi: json["soTienChi"],
        thangGhiNhan: json["thangGhiNhan"],
        namGhiNhan: json["namGhiNhan"],
      );
  }

}


class listyearReport{
  final List<yearReport> listyearReports;

  listyearReport({
    this.listyearReports,
  });

  factory listyearReport.fromJson(Map<String, dynamic> json) {
    List<yearReport> listyearReports = List<yearReport>();
    for (int i =0; i<json["yearReport"].length; i++) {
      listyearReports.add(yearReport.fromMap(json["yearReport"][i]));
    }
    return listyearReport(
      listyearReports: listyearReports,
    );
  }
}

class listitemReport{
  final List<listyearReport> listitemReports;

  listitemReport({
    this.listitemReports,
  });

  factory listitemReport.fromJson(Map<String, dynamic> json) {
    List<listyearReport> listitemReports = List<listyearReport>();
    for (int i =0; i<json["result"]["items"].length; i++) {
      listitemReports.add(listyearReport.fromJson(json["result"]["items"][i]));
    }
    return listitemReport(
      listitemReports: listitemReports,
    );
  }
}






