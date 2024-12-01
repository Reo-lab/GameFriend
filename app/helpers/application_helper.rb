# frozen_string_literal: true

# ApplicationHelper
module ApplicationHelper
  def default_meta_tags
    meta_base.merge(
      og: meta_og,
      twitter: meta_twitter
    )
  end

  private

  def meta_base
    meta_site_info.merge(meta_misc)
  end

  def meta_site_info
    {
      site: 'ゲームフレンド【いま一緒にゲームできる人を探す】',
      title: 'ゲームフレンド【いま一緒にゲームできる人を探す】',
      description: meta_description,
      keywords: meta_keywords,
      canonical: 'https://gamefriend333.com/'
    }
  end

  def meta_misc
    {
      reverse: true,
      separator: '|',
      noindex: !Rails.env.production?,
      icon: meta_icons
    }
  end

  def meta_description
    'ゲームフレンドは、オンラインゲームで一緒に遊ぶ友達を簡単に見つけられるマッチングサイトです。多くのプレイヤーとつながり、楽しいゲーム時間を共有しましょう。'
  end

  def meta_keywords
    'ゲームフレンド, ゲーム仲間探し, オンラインゲーム友達, ゲームマッチング, ゲームコミュニティ, 一緒に遊ぶ友達, マルチプレイヤー友達募集,オーバーウォッチ,ヴァロラント, APEX, ロケットリーグ,'
  end

  def meta_icons
    [
      { href: image_url('favicon.ico') },
      { href: image_url('favicon.ico'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpg' }
    ]
  end

  def meta_og
    {
      site_name: 'ゲームフレンド',
      title: 'ゲームフレンド',
      description: meta_description,
      type: 'website',
      url: 'https://gamefriend333.com/',
      image: image_url('ogp.png'),
      locale: 'ja_JP'
    }
  end

  def meta_twitter
    {
      card: 'summary_large_image',
      site: '@ツイッターのアカウント名',
      image: image_url('ogp.png')
    }
  end
end
