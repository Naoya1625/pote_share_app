require 'rails_helper' 

RSpec.describe User, type: :model do
  before do
    @user = User.create(
      name:  "Naoya",
      email:      "example@example.com",
      password:   "password",
      password_confirmation:   "password",
    )
  end

  
  # 名前、メール、パスワード、パスワード確認があれば有効な状態であること
  it "is valid with a name, email, and password" do
    expect(@user).to be_valid
  end

  # 名がなければ無効な状態であること 
  it "is invalid without a name" do
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end

  # メールアドレスがなければ無効な状態であること
  it "is invalid without a email" do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end

  # メールアドレスの形式が無効なものなら無効な状態であること
  it "is invalid when the email address format is invalid" do
    user = User.new(email: "example@example@com")
    user.valid?
    expect(user.errors[:email]).to include("は不正な値です")
  end

  # 重複したメールアドレスなら無効な状態であること
  it "is invalid with a duplicate email address" do
    #@userのemailは"example@example.com"
    user = User.new(
      email: "example@example.com"
    )
    user.valid?
    expect(user.errors[:email]).to include("はすでに存在します")
  end

  # 重複したユーザー名は有効であること
  it "is valid with same name user" do  
    #@userのnameは"Naoya"
    user = User.new(
      name: "Naoya"
    )
    user.valid?
    expect(user.errors[:name]).to_not include("はすでに存在します")
  end

  # パスワードとパスワード確認が異なるなら無効な状態であること
  it "is invalid if password and password_confirmation are different" do
    user = User.new(
      name:  "Naoya",
      email:      "example@example.com",
      password:   "password-a",
      password_confirmation:   "password-b",
  )
  expect(user).to be_invalid
  end
end