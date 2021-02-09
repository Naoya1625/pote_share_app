require 'rails_helper' 

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.create(:user) #id=1 name="Naoya" email="tester1@example.com"
    @other_user = FactoryBot.create(:user) #id=2 name="Naoya" email="tester2@example.com"
  end

  
  # 名前、メール、パスワード、パスワード確認があれば有効な状態であること
  it "is valid with a name, email, and password" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  # 名がなければ無効な状態であること 
  it "is invalid without a name" do
    user = FactoryBot.build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end

  # メールアドレスがなければ無効な状態であること
  it "is invalid without a email" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end

  # メールアドレスの形式が無効なものなら無効な状態であること
  it "is invalid when the email address format is invalid" do
    user = FactoryBot.build(:user, email: "example@example@com")
    user.valid?
    expect(user.errors[:email]).to include("は不正な値です")
  end

  # 重複したメールアドレスなら無効な状態であること
  it "is invalid with a duplicate email address" do
    user = FactoryBot.create(:user, email:"test@example.com")
    other_user = FactoryBot.build(:user, email: "test@example.com")
    other_user.valid?
    expect(other_user.errors[:email]).to include("はすでに存在します")
  end

  # 重複したユーザー名は有効であること
  it "is valid with same name user" do  
    FactoryBot.create(:user, name:"Naoya")
    user = FactoryBot.build(:user, name: "Naoya")
    user.valid?
    expect(user.errors[:name]).to_not include("はすでに存在します")
  end

  # パスワードとパスワード確認が異なるなら無効な状態であること
  it "is invalid if password and password_confirmation are different" do
    user = FactoryBot.build(:user,password_confirmation: "bbbbbb")
    user.valid?
    expect(user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
  end
end