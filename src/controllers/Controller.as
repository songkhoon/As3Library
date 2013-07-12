package controllers {
	import models.IModel;

	public class Controller implements IController {
		private var _model:IModel;
		public function Controller() {
		}

		public function get model():IModel {
			return _model
		}
	}
}
