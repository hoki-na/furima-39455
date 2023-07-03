require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できない場合' do
      it "nicknameが空では登録できない" do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it "emailが空では登録できない" do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "passwordが空では登録できない" do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = 'aaa11'
        @user.password_confirmation = 'aaa11'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = 'aaa111'
        @user.password_confirmation = 'aaa222'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = 'aaamail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it "パスワードは半角英数字混合であること" do
        @user.password = '111111' # 数字のみのパスワード
        @user.valid?
        expect(@user.errors.full_messages).to include("Password must contain both letters and numbers")

        @user.password = 'aaaaaa' # 英字のみのパスワード
        @user.valid?
        expect(@user.errors.full_messages).to include("Password must contain both letters and numbers")

        @user.password = 'パスワード' # 日本語のパスワード
        @user.valid?
        expect(@user.errors.full_messages).to include("Password must contain both letters and numbers")
      end

       it 'last_name(全角)の入力が必須であること' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid")
      end

      it 'first_name(全角)の入力が必須であること' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid")
      end

      it 'last_name(全角)は全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
        @user.last_name = 'taro' # 半角文字
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid")

        @user.last_name = '123456' # 数字のみ
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid")

        @user.last_name = '太郎' # 全角文字
        expect(@user).to be_valid
      end

      it 'first_name(全角)は全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
        @user.first_name = 'yamada' # 半角文字
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid")

        @user.first_name = '123456' # 数字のみ
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid")

        @user.first_name = '山田' # 全角文字
        expect(@user).to be_valid
      end

      it 'last_name_kana(全角)の入力が必須であること' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid")
      end

      it 'first_name_kana(全角)の入力が必須であること' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid")
      end
    end
  end
end