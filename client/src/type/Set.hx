package type;

/**
 * A generic set object for the lack of one in Haxe 4.0.5, along with much needed features.
 * @author AdvaitTrivedi
 */
@:generic
class Set<T> 
{
	var set: Array<T> = new Array<T>();

	public function new () {}

	public function size() : Int {
		return this.set.length;
	}
	
	public function push(element: T) : Bool {
		if (this.has(element)) {
			return false;
		}
		this.set.push(element);
		return false;
	}
	
	public function remove(element: T) : Bool {
		if (this.has(element)) {
			this.set.remove(element);
			return true;
		}
		return false;
	}
	
	public function has(element : T) : Bool {
		return this.set.indexOf(element) != -1;
	}
	
	public function iterator() : Iterator<T> {
		return this.set.iterator();
	}
	
	public function fromArray(array: Array<T>) {
		for (element in array) {
			this.push(element);
		}
		return this;
	}
}