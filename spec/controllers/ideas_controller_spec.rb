require 'rails_helper'

RSpec.describe IdeasController, type: :controller do
  describe "#new" do
    it "should render the new template" do
      get(:new)
      expect(response).to(render_template(:new))
    end
    it "should assign instance variable @idea" do
      get(:new)
      expect(assigns(:idea)).to(be_a_new(Idea))
    end
  end
end
