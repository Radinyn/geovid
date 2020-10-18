
class Country
{
  String iso;
  int cases;
  double tcpm;
  int new_cases;
  Country(String n_iso, int n_cases, double n_tcpm, int n_new_cases)
  {
    this.iso = n_iso;
    this.cases = n_cases;
    this.tcpm = n_tcpm;
    this.new_cases = n_new_cases;
  }
}