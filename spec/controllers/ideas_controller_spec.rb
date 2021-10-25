require 'rails_helper'

RSpec.describe IdeasController, type: :controller do
  describe "#new" do
    context "user signed in" do
      before do
        session[:user_id] = FactoryBot.create(:user).id
        get(:new)
      end
      it "should render the new template" do
        expect(response).to(render_template(:new))
      end
      it "should assign instance variable @idea" do
        expect(assigns(:idea)).to(be_a_new(Idea))
      end
    end
    context "user not signed in" do
      it "should redirect to sign in page" do
        get(:new)
        expect(response).to(redirect_to(new_session_path))
      end
    end
  end

  describe "#create" do
    context "user signed in" do
      before do
        @current_user = FactoryBot.create(:user)
        session[:user_id] = @current_user.id
      end
      context "with valid parameters" do
        def valid_params
          post(:create, params:{ idea: FactoryBot.attributes_for(:idea, user: @current_user)})
        end
        it "should create a new idea in db" do
          before_count = Idea.all.count
          valid_params
          after_count = Idea.all.count
          expect(after_count).to(eq(before_count + 1))
        end
        it "should redirect to the show page" do
          valid_params
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
    context "user not signed in" do
      it "should redirect to sign in page" do
        post(:create, params:{ idea: FactoryBot.attributes_for(:idea)})
        expect(response).to(redirect_to(new_session_path))
      end 
    end
  end
end
