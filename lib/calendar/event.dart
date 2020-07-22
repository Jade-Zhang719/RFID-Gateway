class Event {
  final DateTime date;
  final String dis;
  final int qty;

  Event(
    this.date,
    this.dis,
    this.qty,
  )   : assert(date != null),
        assert(dis != null),
        assert(qty != null);
}
