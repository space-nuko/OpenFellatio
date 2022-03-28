class ArrayTools {
  static public function append<T>(target:Array<T>, toBeAdded:Array<T>) {
    for (x in toBeAdded) target.push(x);
    return target;
  }
}
