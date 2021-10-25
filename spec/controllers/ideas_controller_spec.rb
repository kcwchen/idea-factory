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

  describe "#create" do
    context "with valid parameters" do
      it "should create a new idea in db" do
        before_count = Idea.all.count
        post(:create, params:{ idea: FactoryBot.attributes_for(:idea)})
        after_count = Idea.all.count
        expect(after_count).to(eq(before_count + 1))
      end
      it "should redirect to the show page" do
        post(:create, params:{ idea: FactoryBot.attributes_for(:idea)})
        i = Idea.last
        expect(response).to(redirect_to(idea_path(i.id)))
      end
    end
    context "with invalid parameters" do
      it "should not create a new idea in db" do
        before_count = Idea.all.count
        post(:create, params:{ idea: FactoryBot.attributes_for(:idea, title: nil)})
        after_count = Idea.all.count
        expect(after_count).to(eq(before_count))
      end
      it "should render the new template" do
        post(:create, params:{ idea: FactoryBot.attributes_for(:idea, title: nil)})
        expect(response).to(render_template(:new))
      end
    end
  end
end
