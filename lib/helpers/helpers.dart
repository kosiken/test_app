String reduceString(String s, {int length = 11}) {
  if (s.length > length) return "${s.substring(0, length)}...";
  return s;
}
