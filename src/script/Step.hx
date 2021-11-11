package script;

/**
 * ...
 * @author Sith
 */

class Step {
	
	public var set : Array<Setup>;
	public var task : Task;
	
	public var tools : Array<String>;
	
	public var comment_success : String;
	public var comment_failed : String;
	public var comment_notification : String;
	
	public function new() {
	}
	
}