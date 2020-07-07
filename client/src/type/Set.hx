package type;

/**
 * A generic set object for the lack of one in Haxe 4.0.5, along with much needed features.
 * 
 * TODO : Should have generic <T : Equals/DeepEquals> where Equals is an interface that is implemented by consituent members for deep equality.
 * This also points to the fact that the check methods should enable deep equality. (Even if it is using a boolean parameter)
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
	
	/**
	 * Attempts to push an element onto the set.
	 * If element already exists in the set then the push will be rejected, and false will be returned.
	 * @param	element
	 * @return
	 */
	public function push(element: T) : Bool {
		if (this.has(element)) {
			return false;
		}
		this.set.push(element);
		return true;
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
	
	public function get(key: Int) : T {
		if (key >= 0 && key < this.size()) {
			return this.set[key];
		}
		
		return null;
	}
}