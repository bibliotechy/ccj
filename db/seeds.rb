User.where({email: "admin@ccj.org"})
  .first_or_create do |user|
    user.password = "ccjadmin"
  end unless Rails.env.production?


artists_details = [
  {
    name_en: "NAKAJIMA Ko",
    name_jp: "中嶋興氏 ",
    description_en: %Q[
    Nakajima Ko began his career in experimental animation with the creation of works such as Seizoki (1964). At his solo exhibition at the Sogetsu Art Center, a space for avant-garde art in 1960s Tokyo, he produced Seizoki by painting directly on the film between screenings. His perennial interest in integrating new technologies, exploring the potential of film, video, and eventually computer animation, joined his desire to explore human intersections with nature, as seen in his Biological Cycle series (1971-); he created the first work in the series, Biological Life (1971-), by copying manipulated film footage onto video, then further manipulating the work with a video synthesizer.

In 1971, Nakajima established Video Earth Tokyo, the pioneering video-art collective. Nakajima used one of the earliest available portable video recorders to document Video Earth Tokyo performance pieces and teach the new technology. Video Earth Tokyo members created works, broadcast works on cable television, and participated in international exhibitions and emergent CG (computer graphics) conferences. In 1982, Nakajima introduced his Aniputer.  Aniputer technology allowed wide access to creation of video animation, as this personal portable computer integrated with a video camera, developed in collaboration with Japan Victor Company (JVC), allowed any user to directly manipulate video and images on a screen, creating animations in real time. Nakajima used his expertise manipulating film, photography, and video with computer technology to create what is perhaps his best known work, Mt. Fuji (1984), a ninety-minute rhythmic meditation on nature, spirituality, and perspective.

Nakajima has produced works in France, Canada, New Zealand, and Denmark. Representative works include Biological Cycle series (1971-), My Life series (1976-), Mt. Fuji (1984), and Dolmen (1987). His works are in permanent collections internationally, including in Centre Georges Pompidou (France), The Museum of Modern Art (U.S.), Long Beach Museum of Art Video Archive (U.S.), and the Getty Research Institute Special Collections (U.S.).

    ],
    description_jp: ""
  },
  {
    name_en: "MIYAI Rikuro",
    name_jp: "宮井陸郎",
    description_en: %Q[
    Rikuro Miyai (b. 1940, Shimane) is an artist with a multidisciplinary practice. As a student at Waseda University, Miyai joined the Association of Documentary Filmmakers and was an active voice in documentary film criticism. By the mid-1960s, he began to regularly feature in popular weekly magazines as a model and cultural voice representing the hippie (fūten) phenomenon while he continued to write criticism for the film journals Eizo Geijutsu and Kikan Firumu. His own films brought together his critical interests in documentary and pop, which grew through his admiration of Andy Warhol, and culminated in his 1965 essay ‘The Pop-Cinema Approach to Phenomenological Documentary’ and his double-projection film performance Phenomenology of Zeitgeist (1968). Together with Shuzo Azuchi Gulliver, he presented his own films at jazz clubs, such as Pit Inn and Noa Noa, and participated in events such as Pull Event (1967) at Sogetsu Art Centre, Intermedia (1967) at Runami Gallery and ZONE (1968), organised by the Art Film Association in Kyoto. He began to design discotheques and bars, such as Killer Joe’s, Club Sharivari and Station ’70 in Tokyo and Space Delicious in Osaka, expanding his practice to incorporate environment design. He participated in the 1970 World Exposition in Osaka (Osaka Expo ’70) where he became one of only several artists who were able to stage a performance in the Mirror dome of the Pepsi Pavilion designed by E.A.T before its cancellation. Miyai was a founding member of Video Hiroba, a collective of early video artists in Japan, and the leader of Unit Pro, an independent film production unit set up in his apartment in Shinjuku, Tokyo. He has recently presented his performances at Tate Modern, International Film Festival Rotterdam, Art Institute of Chicago and Tokyo Photographic Art Museum.
    ],
    description_jp: %Q[
    宮井陸郎（1940年生、島根出身）、複数の表現領域で活動するアーティスト。早稲田大学学生時代、記録映画作家協会に入会、ドキュメンタリー映画批評を積極的に行う。 1960年代半まで、ヒッピー（フーテン）現象を代表するモデル兼文化人として、流行の週刊誌に定期的に登場するようになるが、その一方で、雑誌『映像芸術』、『季刊フィルム』にて映画批評を続ける。宮井自身の映画作品は、ドキュメンタリーとポップへの批判的関心を集約したもので、アンディ・ウォーホルへの敬愛を通じて培われた。その結果生まれたのが、1965年に書かれたエッセイ「現象学的ドキュメンタリーへのポップ・シネマ的アプローチ」と、フィルムを二重に投映した作品「時代精神の現象学」（1968 ）である。シュウゾウ・アヅチ・ガリバーと共に「ピットイン」や「ノアノア」などジャズクラブで自らの作品を発表、草月アートセンターでの「プルイベント」（1967年）、ルナミギャラリー「インターメディア」（1967年）、また京都での映像芸術の会が主催した「ZONE」（1968年） といったイベントに参加。 さらに「キラージョーズ」、「クラブシャリヴァリ」、「ステーション70」（東京）や「スペースデリシャス」（大阪）などのディスコやバーのデザインを開始、環境デザインを取り入れ実践を拡げる。
    1970年には大阪万博（大阪万博'70）に参加。E.A.T.がデザインしたペプシ館ミラードーム内で、予定されていたプログラムが途中キャンセルされる前にパフォーマンスを演じた数少ないアーティストの一人となる。日本における初期ビデオアーティスト集団「ビデオひろば」の創設メンバー、東京新宿の自宅アパートに設けたインディペンデント映画製作所「ユニットプロ」のリーダー。近年テート・モダン、ロッテルダム国際映画祭、シカゴ美術館、東京都写真美術館でパフォーマンスを上演。
    ],
  },
  {
    name_en: "AZUCHI GULLIVER　Shuzo",
    name_jp: "シュウゾウ・アヅチ・ガリバー ",
    description_en: %Q[
   Shuzo Azuchi Gulliver (b. 1947, Shiga) is an artist with a multidisciplinary practice. As a high school student, he formed the artist collectives The Play and Remandaran and staged on-street performances of a conceptual nature in Kyoto and Osaka. Living between Tokyo and the Kansai region in the late-1960s, he began to attract the attention of the media and was considered to be a representative figure of the hippie (fūten) phenomenon, going by the nickname Gulliver, which he continues to keep as his artist name. In 1967, he presented a series of conceptually driven films at the discotheque L.S.D in Tokyo. Together with Rikuro Miyai, he began presenting film in Tokyo jazz clubs, such as Pit Inn and Noa Noa as well as at events organised by the Art Film Association in Kyoto and Osaka. As a participant of the Intermedia Art Festival at the discotheque Killer Joe’s, Tokyo, in 1969, Gulliver presented Cinematic Illumination (1968-69), a work involving eighteen slide projectors that illuminated the unique 360-degree environment. The outdoor performance Flying Focus (1969) involved a tubular balloon into which Gulliver projected coloured patterns using an overhead projector. Since, he has continued to remain active as an artist working in the fields of sculpture, performance and new media with an interest in the body, scale and humour. He is represented by Tajana Pieters (Ghent) and Aoyama Meguro (Tokyo) and has performed or exhibited his work recently at Tate Modern and Tokyo Photographic Art Museum.
    ],
    description_jp: %Q[
    シュウゾウ・アヅチ・ガリバー（Shuzo Azuchi Gulliver、1947年生、滋賀県出身）、複数の表現領域で活動するアーティスト。高校時代、アーティスト集団The Play、れまんだらんを結成、京都と大阪でコンセプチュアルな路上パフォーマンスを上演する。 1960年代後半、東京と関西を往復して暮らすなか、メディアの注目を集め、ヒッピー（フーテン）現象の代表的な人物となる。アーティスト名として今でも使われている"ガリバー"はその当時のあだ名。 1967年、東京のディスコ「L.S.D」にてコンセプチュアルなフィルム作品を発表する。宮井陸郎と共に、「ピットイン」や「ノアノア」といった東京のジャズクラブや、京都と大阪での「映像芸術の会」が主催するイベントにてフィルム作品を発表。1969年には東京のディスコ「キラー・ジョーズ」（Killer Joe's）でのインターメディア・アート・フェスティバルに参加、１８台のスライドプロジェクターが独自の３６０度スクリーンに映像を投映する作品「Cinematic Illumination」（1968-69）を発表。また、野外パフォーマンス「Flying Focus」（1969）では、オーバーヘッドプロジェクターを使用し、管状の風船に色彩模様を投映した。以来、「身体」、「スケール」、「ユーモア」への関心を持ちながらアーティストとして彫刻、パフォーマンス、ニューメディアの領域で活動を続ける。ギャラリーTajana Pieters（ゲント）及び青山目黒（東京）所属。近年、テートモダン、東京写真美術館にてパフォーマンス、展覧会を開催。

    ]

  },
  {
    name_en: "OE Masanori",
    name_jp: "おおえまさのり",
    description_en: %Q[
Masanori Oe (b. 1942) is a filmmaker, writer and translator. Moving to New York in his early twenties between 1965-68, he got involved in the Third World Studios together with Stan Vanderbeek and Jonas Mekas. Joining Marvin Fishman at Studio M2, Oe began filming protest activities as part of the Newsreel Collective. He participated in USCO’s psychedelic shows and translated his psychedelic experiences into his films Between the Frames (1967) and Salome’s Children (1968). Together with Yukihisa Isobe, he participated in the exhibition Some More Beginnings by E.A.T. at the Brooklyn Museum in 1968. His work in psychedelic culture and political activism came together in Great Society (1967), co-directed by Marvin Fishman, a six-screen collage of newsreel footage from the television broadcast company CBS who commissioned them to make it. Upon returning to Japan, he co-founded Newsreel Japan with filmmaker Masato Hara and photographers Takuma Nakahira and Kenji Kanesaka. They joined members of the collective Zero Jigen and others to halt the 1969 edition of Tokyo Film Art Festival at Sogetsu Art Centre on the grounds that the film festival’s competition format encouraged a hierarchy among films, an act that was met with controversy. He followed the collective Zero Jigen to shoot their film White Hare of Inaba (1970). He translated The Tibetan Book of the Dead, published in Japanese by Kodansha in 1974, and wrote extensively on his LSD experiences. He helped to found one of the first health-food stores in Japan and became an organic farmer. His works have recently been presented at Museum of Modern Art, Tate Modern and Tokyo Photographic Art Museum.
    ],
    description_jp: %Q[
おおえまさのり（1942年生）映像作家、作家、翻訳家。 二十代前半1965年から1968年の間、ニューヨークに移住、スタン・ヴァンダービーク、ジョナス・メカスと共に「Third World Studios」に参加。スタジオM2にてマーヴィン・フィッシュマンと共同し、Newsreel Collectiveの一環として抗議活動の撮影を開始。また、USCOが企画したサイケデリックイベントに参加、自らの幻覚体験を「Between the Frames」（1967）、「Salome's Children」（1968）といった作品に表現する。1968年、ブルックリン美術館でのE.A.T.主催「Some More Beginnings」展に磯辺行久と共に参加。また、サイケデリック文化と政治的アクティヴィズムにおける彼の仕事の結集である「Great Society」(1967)は、放送ネットワークCBSより製作を委嘱され、マーヴィン・フィッシュマンと共同監督し、CBSのニュース映像による６面スクリーンを使ったコラージュ作品である。帰国後、映像作家の原正人、写真家の中平卓馬、金坂健二と共にNewsreel Japanを発足。また、集団「ゼロ次元」のメンバーらと共闘、主催者によるコンペ形式の採用が映画のヒエラルキー化を助長することに抗議、草月アートセンターでの「フィルム・アート・フェスティバル1969東京」を中止に追い込む。「ゼロ次元」に同行し、映画「いなばの白うさぎ」（1970）を撮影。『チベットの死者の書』を邦訳し、1974年、講談社から出版される。LSD体験に関する文章多数。日本初の健康食品店の設立を援助し、有機栽培農家となる。近年ニューヨーク近代美術館（MoMA)、テートモダン、東京都写真美術館で作品を発表。
],

  },
  {
    name_en: "IIMURA Takahiko",
    name_jp: "飯村隆彦",
    description_en: %Q[
    Takahiko Iimura (b. 1937, Tokyo) is an artist and filmmaker who has lived between Tokyo and New York throughout his artistic career. Together with Nobuhiko Obayashi and Yoichi Takabayashi, Iimura was one of the first to organise screenings of 8mm films outside of amateur home movie circles in the early 1960s. Presenting screenings at gallery spaces, including the first in a series of Naiqua Cinematheque screenings held at Naiqua Gallery, Tokyo, in 1963, Iimura’s peers mostly consisted of artists rather than filmmakers, which led to several collaborations: Yoko Ono created the sound design of Ai (Love) (1962-63); Natsuyuki Nakanishi co-directed On Eye Rape (1963), an early Japanese found footage film; and Sho Kazakura performed happenings for the camera in Dance Party in the Kingdom of Lilliput (1964). These collaborations influenced the way Iimura presented his films, which led to his early experiments in expanded cinema and, eventually, film and video installations. After winning a group prize at the experimental film festival EXPRMNTL in Knokke-le-Zoute, Belgium, in 1963, Iimura co-founded the Film Independents with the other recipients. Encouraged by a positive review of his film Ai (Love) by Jonas Mekas, Iimura relocated to New York in 1966 where he initiated further collaborations, such as with Alvin Lucier. Returning to Tokyo in 1969, Iimura began immersing himself in video art and, ever since, has been considered a pioneer of expanded cinema, video art and film installation in Japan. His works have been presented at Centre Pompidou, Museum of Modern Art, Tokyo Photographic Art Museum and Eye Filmmuseum.
    ],
    description_jp: %Q[
飯村隆彦（1937年生、東京出身）は、東京とニューヨークを拠点に活動するアーティスト、映像作家。1963年、日本のネオ・ダダの前衛画廊であった、内科画廊での最初の個展上映を「内科シネマテーク」として始め、また、画家、中西夏之や音楽家、刀根康尚らのアーテイストと「フィルム・アンデパンダン」を組織、紀伊国屋ホールで上映する。 アーティストとの交流が多かったことから、小野洋子による 「Ai (Love)」（1962-63）の音楽、日本における初期ファウンド・フッテージフィルムにパンチを連続して空けたパフォーマンス「視姦について」（1963）を中西夏之と共同制作。さらに「リリパッド王国舞踏会」（1964年）では主演の風倉匠によるパフォーマンスを演出する。これらのコラボレーションは、飯村の作品の上映方法を拡大して、のちの拡張映画の前例となり、その後の映画やビデオ・インスタレーションへと発展する。 1964年、ベルギーのクノック・ル・ズーの実験映画祭「EXPRMNTL」では「オナン」が特別賞を受賞。1966年には、「Ai」（Love）がジョナス・メカスによりビレッジ・ボイス紙に高く評価され、さらにハーバード大學の国際セミナーの招待により、渡米、ニューヨークに移住する。音楽のアルヴァン・ルシエとニューヨークのDomなどで「シェルター9999」をライブ公演する。1969年からビデオアートを始め、「タイム３部作」（1973）や「オブザーバー/オブザーブド」（1976）「ビデオの記号学」（1975-1976）などビデオ固有のテーマを制作する。ベルリンの以来、拡張映画、ビデオアート、ビデオインスタレーションにおける先駆的アーティストとしてパのポンピドゥセンター、ニューヨーク近代美術館（MoMA）、東京都写真美術館などにて作品を展示, 上映し、収蔵作品ともなっている。
    ]

  },
  {
    name_en: "Keiichi Tanaami",
    name_jp: "田名網敬",
    description_en: %Q[
    Tanaami Keiichi (b. 1936, Tokyo) is an artist, graphic designer and animation filmmaker. While still a student at the Mushashino Art University, his career took off when he received a special selection award at the 1958 Japan Advertising Art Exhibition. He participated in the Animation Festival at Sogetsu Art Center in 1965 and 1966, after which his animation works frequently screened at international film festivals such as International Short Film Festival Oberhausen, New York Film Festival and Ottawa International Animation Festival. Tanaami became known as a leading figure of pop art and psychedelic art in Japan as his print-based, sculptural works and films grew increasingly popular in the 1960-70s. Designing record covers, posters, and taking on the role of Art Director for the Japanese edition of PLAYBOY in 1975, he often bridged commercial work and art practice ––it was just as likely to see his work on a magazine cover as an art exhibition. Now represented by NANZUKA, his career continues to be as prolific as ever with works exhibited recently at Walker Art Center, Museum of Modern Art (New York), Hamburger Bahnhof, and Tate Modern.
    ],
    description_jp: %Q[
田名網敬一（1936年生、東京出身）アーティスト、グラフィックデザイナー、アニメーション映像作家。武蔵野美術大学の学生当時、1958年日宣美展にて特別選考賞を受賞し作家活動を開始。 1965年、1966年、草月アートセンターでのアニメーションフェスティバルに参加。その後、オーバーハウゼン国際短編映画、ニューヨーク映画祭、オタワ国際アニメーションフェスティバルなどの国際映画祭にて作品が頻繁に上映されるようになる。1960-70年代、プリントや彫刻作品、映画が人気を博すにつれて、日本におけるポップアート、サイケデリックアートの先駆的アーティストとして知られるようになる。レコードアルバムのカバーやポスターのデザイン、1975年には日本版『PLAYBOY』のアートディレクターに就任する。作品はアート作品の展示と同様に、雑誌のカバーデザインとしても広まり、アートと商業作品の架橋となる。現在NANZUKAに所属、作家活動を続けるなか多くの作品を生み出している。近年、ウォーカー・アート・センター、ニューヨーク近代美術館（MoMA)、森美術館、テート・モダンで展覧会が開催された。
    ]

  },
]

artists_details.each do |ad|
  artist = Artist.where("lower(name_en) = lower(?)", "#{ad[:name_en]}".strip).first_or_create
  artist.name_en ||= ad[:name_en]
  artist.name_jp ||= ad[:name_jp]
  artist.description_en ||= ad[:description_en]
  artist.description_jp ||= ad[:description_jp]
  artist.save!
end
