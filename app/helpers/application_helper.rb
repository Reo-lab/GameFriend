# frozen_string_literal: true

# ApplicationHelper
module ApplicationHelper
  def default_meta_tags
    {
      site: 'ゲームフレンド',
      title: 'ゲームフレンド',
      reverse: true,
      separator: '|',
      description: 'ゲームフレンドは、オンラインゲームで一緒に遊ぶ友達を簡単に見つけられるマッチングサイトです。多くのプレイヤーとつながり、楽しいゲーム時間を共有しましょう。',
      keywords: 'ゲームフレンド, ゲーム仲間探し, オンラインゲーム友達, ゲームマッチング, ゲームコミュニティ, 一緒に遊ぶ友達, マルチプレイヤー友達募集,オーバーウォッチ,ヴァロラント, APEX, ロケットリーグ,',
      canonical: request.original_url,
      noindex: ! Rails.env.production?,
      icon: [
        { href: image_url('favicon.ico') },
        { href: image_url('favicon.ico'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpg' },
      ],
      og: {
        site_name: 'ゲームフレンド',
        title: 'ゲームフレンド',
        description: 'ゲームフレンドは、オンラインゲームで一緒に遊ぶ友達を簡単に見つけられるマッチングサイトです。多くのプレイヤーとつながり、楽しいゲーム時間を共有しましょう。', 
        type: 'website',
        url: request.original_url,
        image: image_url('favicon.ico'),
        locale: 'ja_JP',
      },
      twitter: {
        card: 'summary_large_image',
        site: '@ツイッターのアカウント名',
      }
    }
  end
end
