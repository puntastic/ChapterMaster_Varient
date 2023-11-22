//*grumbles* var == undefined is invalid. And I don't trust the 'truthyness' of noone
function IsEqual(a, b)
{
	if(is_undefined(a) || is_undefined(b)) { return is_undefined(a) && is_undefined(b); }
	return a == b;
}