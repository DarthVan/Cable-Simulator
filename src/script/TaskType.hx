package script;

/**
 * @author Sith
 */

enum abstract TaskType(String) to String {
	
	var SELECT = 'select';
	var PICK = 'pick';
	var TOOL = 'tool';
	var WAIT = 'wait';
	var COMMENT = 'comment';
	var COMMENT_SUCCESS = 'comment_success';
	var ASKFIX = 'askfix';
	
}