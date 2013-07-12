package controllers
{
	import models.IModel;

	public interface IController
	{
		function get model():IModel;
	}
}