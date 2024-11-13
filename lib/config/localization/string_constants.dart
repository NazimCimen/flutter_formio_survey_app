// ignore_for_file: public_member_api_docs, non_constant_identifier_names

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';

@immutable
final class StringConstants {
  const StringConstants._();
  static String get appName => 'Formio';
  static String get main_page => 'Ana Sayfa';
  static String get loading => 'loading'.tr();
  static String get log_in => 'log_in'.tr();
  static String get log_in_to_continue => 'log_in_to_continue'.tr();
  static String get email => 'email'.tr();
  static String get password => 'password'.tr();
  static String get enter_your_email => 'enter_your_email'.tr();
  static String get enter_your_password => 'enter_your_password'.tr();
  static String get or_login_with => 'or_login_with'.tr();
  static String get dont_have_an_account => 'dont_have_an_account'.tr();
  static String get register_here => 'register_here'.tr();
  static String get sign_up => 'sign_up'.tr();
  static String get enter_your_personal_informations =>
      'enter_your_personal_informations'.tr();
  static String get username => 'username'.tr();
  static String get enter_your_username => 'enter_your_username'.tr();
  static String get or_sign_up_with => 'or_sign_up_with'.tr();
  static String get already_have_an_account => 'already_have_an_account'.tr();
  static String get todays_surveys => 'todays_surveys'.tr();
  static String get ready_to_discover_surveys =>
      'ready_to_discover_surveys'.tr();
  static String get search_survey => 'search_survey'.tr();

  static String get loading_survey => 'loading_survey'.tr();
  static String get settings => 'settings'.tr();
  static String get help_center => 'help_center'.tr();
  static String get give_feedback => 'give_feedback'.tr();
  static String get about_app => 'about_app'.tr();
  static String get policy_privacy => 'policy_privacy'.tr();
  static String get theme => 'theme'.tr();
  static String get light_mode => 'light_mode'.tr();
  static String get dark_mode => 'dark_mode'.tr();
  static String get language => 'language'.tr();
  static String get select_language => 'select_language'.tr();

  static String get force_update => 'Yeni Bir Güncelleme Sizi Bekliyor!';
  static String get force_update_desc =>
      'En yeni özellikler ve iyileştirmelerle deneyiminizi bir üst seviyeye taşıdık. Devam edebilmek için lütfen uygulamanızı güncelleyin.';
//////////////////////////////////////////////////////////////////////////////////
  static String get home_title => 'Görüşleri Al,\nTrendleri Bul';
  static String get home_title_desc =>
      'Formio ile anketlerin oluştur yanıtları analiz et ve trendleri yakala.';
  static String get published_surveys => 'Yayınladığım Anketler';
  static String get answered => 'Yanıtlanan';
  static String get no_survey_lets_do =>
      'Henüz bir anketiniz yok, haydi hemen bir tane oluşturalım!';
  static String get create_now => 'Hemen Oluştur';

//////////////////////////////////////////////////////////////////////////////////////
  static String get cancel => 'İPTAL';
  static String get save => 'KAYDET';
  static String get next => 'İLERİ';
  static String get refresh => 'Yeniden Dene';
  static String get close => 'Kapat';
  static String get camera => 'Kamera';
  static String get gallery => 'Galeri';
  static String get publish => 'YAYINLA';
  static String get add_question_to_survey => 'Lütfen Anketinize soru ekleyin';

  static String get error_connection => 'Bağlantı Hatası';
  static String get error_connection_msg => 'İnternet bağlantı hatası oluştu.';
  static String get error_connection_msg_try =>
      'İnternet Bağlantınız yok. Bağlantınızı kontrol edip tekrar deneyin';

  static String get error_unknown_msg => 'Bilinmeyen hata oluştu:';
  static String get error_unknown_msg_try =>
      'Bir Sorun Oluştu Daha Sonra Tekrar Deneyin..';
  static String get error_no_added_question =>
      'Henüz soru oluşturmadınız! Soru eklemek için aşağıdaki butona tıklayın.';

  static String get valid_mail1 => 'Lütfen geçerli bir e-posta giriniz';
  static String get valid_mail2 => 'Geçersiz e-posta formatı';
  static String get valid_password1 => 'Lütfen şifrenizi giriniz';
  static String get valid_password2 => 'Şifreniz en az 6 karakter olmalıdır';
  static String get valid_password3 =>
      'Şifreniz en az bir harf ve bir rakam içermelidir';

  static String get valid_username1 => 'Lütfen kullanıcı adınızı giriniz';
  static String get valid_username2 =>
      'Kullanıcı adınız 3 ile 10 karakter arasında olmalıdır';
  static String get valid_username3 =>
      'Kullanıcı adınız sadece harf, rakam ve alt çizgi içerebilir';
  static String get valid_survey_title1 => 'Anket başlığı boş olamaz';
  static String get valid_survey_title2 =>
      'Anket başlığı en fazla 50 karakter olmalıdır';
  static String get valid_survey_desc1 => 'Anket açıklaması boş olamaz';
  static String get valid_survey_desc2 =>
      'Anket açıklaması en fazla 200 karakter olmalıdır';
  static String get valid_survey_startdate1 => 'Başlangıç tarihi boş olamaz';
  static String get valid_survey_startdate2 =>
      'Geçersiz başlangıç tarihi formatı. Doğru format: yyyy-MM-dd';
  static String get valid_survey_enddate1 => 'Bitiş tarihi boş olamaz';
  static String get valid_survey_enddate2 =>
      'Geçersiz bitiş tarihi formatı. Doğru format: yyyy-MM-dd';
  static String get valid_survey_minute =>
      'Lütfen geçerli bir dakika değeri giriniz';
  static String get valid_question_text =>
      'Soru Metnini girmeden ilerleyemezsiniz';
  static String get valid_question_option => 'Lütfen seçenek alanını doldur';
  static String get crop_bar_title => 'Resmi Kırp';

  static String get question_options => 'Seçenekler';
  static String get question_enter_options => 'Seçenek girin';
  static String get question_image => 'Soru Resmi';
  static String get question_rules => 'Kurallar';
  static String get question_required_answer => 'Cevaplaması zorunlu soru';
  static String get question_multiple_choice => 'Çoklu Seçim Özelliği';
  static String get question_add_other => 'Seçeneklere Diğer ekle';
  static String get question_title => 'Soru Başlığı';

  static String get question_type_multiple => 'Çoktan Seçmeli';
  static String get question_type_open_ended => 'Açık Uçlu';
  static String get question_type_dropdown => 'Aşağı Açılır';

  static String get question_input_hint => 'Sorunuzu Yazın';
  static String get question_input_title => 'Sorunuzu Metni';

  static String get survey_image => 'Anket Resmi';
  static String get survey_title => 'Anket Başlığı';
  static String get survey_desc => 'Anket Açıklaması';
  static String get survey_start_date => 'Başlangıç Tarihi';
  static String get survey_end_date => 'Bitiş Tarihi';
  static String get survey_minute => 'Anket Yanıtlama Süresi';

  static String get survey_succes =>
      'Anketiniz Başarılı bir şekilde oluşturuldu.';
  static String get survey_share => 'Paylaş';
  static String get survey_share_menu_title => 'Bu anketi doldur';
  static String get survey_copy_link => 'Linki Kopyala';
  static String get survey_link_coppied => 'Link kopyalandı!';

  static String get survey_create_ur_survey => 'Anketini Oluştur';
  //////////////////////////////////////////////////////////////////////////////////////
}
