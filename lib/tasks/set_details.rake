# frozen_string_literal: true

namespace :set_details do
  desc "Load artist details"
  task :artists => :environment do
    artists_details.each do |ad|
      begin
        artist = Artist.find_or_create_by(name_jp: "#{ad[:name_jp]}")
        puts "#{ad[:name_en]}" unless artist
        artist.name_en ||= ad[:name_en]
        artist.name_jp ||= ad[:name_jp]
        artist.description_en ||= ad[:description_en]
        artist.description_jp ||= ad[:description_jp]
        artist.save!
      rescue => e
        "Failed to save artist because #{e}"
      end
    end
  end

  desc "Load Collection Information"
  task :collections => :environment do
    collection_details.each do |cd|
      collection = Collection.find_by(name_en: "#{cd[:name_en]}")
      collection.name_jp ||= cd[:name_jp]
      collection.description_en ||= cd[:description_en]
      collection.description_jp ||= cd[:description_jp]
      collection.website ||= cd[:website]
      collection.save!
    end
  end
end

def artists_details
  [
    {
      name_en: "NAKAJIMA Ko",
      name_jp: "中嶋興",
      description_en: %Q[
        Nakajima Ko ​(b. 1941, Kumamoto Prefecture)​ began his career in experimental animation with the creation of works such as ​Seizoki​ (1964). At his solo exhibition at the Sogetsu Art Center, a space for avant-garde art in 1960s Tokyo, he produced ​Seizoki​ by painting directly on the film between screenings. His perennial interest in integrating new technologies, exploring the potential of film, video, and eventually computer animation, joined his desire to explore human intersections with nature, as seen in his ​Biological Cycle​ series (1971-); he created the work by copying manipulated film footage onto video, then further manipulating the work with a video synthesizer. In 1971, Nakajima established Video Earth Tokyo, the pioneering video-art collective. Nakajima used one of the earliest available portable video recorders to document Video Earth Tokyo performance pieces and teach the new technology. Video Earth Tokyo members created works, broadcast works on cable television, and participated in international exhibitions and emergent CG (computer graphics) conferences. In 1982, Nakajima introduced his Aniputer. Aniputer technology allowed wide access to creation of video animation, as this personal portable computer integrated with a video camera, developed in collaboration with Japan Victor Company (JVC), allowed any user to directly manipulate video and images on a screen, creating animations in real time. Nakajima used his expertise manipulating film, photography, and video with computer technology to create what is perhaps his best known work, ​Mt. Fuji​ (1984), a ninety-minute rhythmic meditation on nature, spirituality, and perspective. Nakajima has produced works in France, Canada, New Zealand, and Denmark. Representative works include ​Biological Cycle​ series (1971-), ​My Life​ series (1976-), ​Mt. Fuji (1984), and ​Dolmen​ (1987). His works are in permanent collections internationally, including in Centre Georges Pompidou (France), The Museum of Modern Art (U.S.), Long Beach Museum of Art Video Archive (U.S.), and the Getty Research Institute Special Collections (U.S.).
      ],
      description_jp: ""
    },
    {
      name_en: "MIYAI Rikuro",
      name_jp: "宮井陸郎",
      description_en: %Q[
        Rikuro Miyai (b. 1940, Shimane Prefecture) is an artist with a multidisciplinary practice. As a student at Waseda University, Miyai joined the Association of Documentary Filmmakers and was an active voice in documentary film criticism. By the mid-1960s, he began to regularly feature in popular weekly magazines as a model and cultural voice representing the hippie (fūten) phenomenon, while he continued to write criticism for the film journals ​Eizo Geijutsu​ and Kikan Firumu.​ His own films brought together his critical interests in documentary and pop, which grew through his admiration of Andy Warhol, and culminated in his 1965 essay “The Pop-Cinema Approach to Phenomenological Documentary’ and his double-projection film performance ​Phenomenology of Zeitgeist ​(1968). Together with Shuzo Azuchi Gulliver, he presented his own films at jazz clubs, such as Pit Inn and Noa Noa, and participated in events such as Pull Event (1967) at Sogetsu Art Centre, Intermedia (1967) at Runami Gallery, and ZONE (1968), organised by the Art Film Association in Kyoto. He began to design discotheques and bars, such as Killer Joe’s, Club Sharivari, and Station ’70 in Tokyo, and Space Delicious in Osaka, expanding his practice to incorporate environment design. He participated in the 1970 World Exposition in Osaka (Osaka Expo ’70), where he became one of the artists who were able to stage a performance in the Mirror dome of the Pepsi Pavilion, which was designed by E.A.T. (Experiments in Art and Technology) before its cancellation. Miyai was a founding member of Video Hiroba, a collective of early video artists in Japan, and the leader of Unit Pro, an independent film production unit set up in his apartment in Shinjuku, Tokyo. He has recently presented his performances at Tate Modern, International Film Festival Rotterdam, Art Institute of Chicago, and Tokyo Photographic Art Museum.
      ],
      description_jp: %Q[
        宮井陸郎(1940年生、島根出身)、複数の表現領域で活動するアーティスト。早稲田大 学学生時代、記録映画作家協会に入会、ドキュメンタリー映画批評を積極的に行う。 1960年代半まで、ヒッピー(フーテン)現象を代表するモデル兼文化人として、流行の 週刊誌に定期的に登場するようになるが、その一方で、雑誌『映像芸術』、『季刊フィ ルム』にて映画批評を続ける。宮井自身の映画作品は、ドキュメンタリーとポップへの 批判的関心を集約したもので、アンディ・ウォーホルへの敬愛を通じて培われた。その 結果生まれたのが、1965年に書かれたエッセイ「現象学的ドキュメンタリーへのポッ プ・シネマ的アプローチ」と、フィルムを二重に投映した作品「時代精神の現象学」( 1968 )である。シュウゾウ・アヅチ・ガリバーと共に「ピットイン」や「ノアノア」 などジャズクラブで自らの作品を発表、草月アートセンターでの「プルイベント」( 1967年)、ルナミギャラリー「インターメディア」(1967年)、また京都での映像芸術 の会が主催した「ZONE」(1968年) といったイベントに参加。 さらに「キラー ジョーズ」、「クラブシャリヴァリ」、「ステーション70」(東京)や「スペースデリ シャス」(大阪)などのディスコやバーのデザインを開始、環境デザインを取り入れ実 践を拡げる。 1970年には大阪万博(大阪万博'70)に参加。E.A.T.がデザインしたペプ シ館ミラードーム内で、予定されていたプログラムが途中キャンセルされる前にパ フォーマンスを演じた数少ないアーティストの一人となる。日本における初期ビデオ アーティスト集団「ビデオひろば」の創設メンバー、東京新宿の自宅アパートに設けた インディペンデント映画製作所「ユニットプロ」のリーダー。近年テート・モダン、 ロッテルダム国際映画祭、シカゴ美術館、東京都写真美術館でパフォーマンスを上演。
      ],
    },
    {
      name_en: "AZUCHI GULLIVER Shuzo",
      name_jp: "シュウゾウ・アヅチ・ガリバー",
      description_en: %Q[
        Shuzo Azuchi Gulliver (b. 1947, Shiga Prefecture) is an artist with a multidisciplinary practice. As a high school student, he formed the artist collectives The Play and Remandaran and staged on-street performances of a conceptual nature in Kyoto and Osaka. Living between Tokyo and the Kansai region in the late-1960s, he began to attract the attention of the media and was considered to be a representative figure of the hippie (fūten) phenomenon, going by the nickname Gulliver, which he continues to keep as his artist name. In 1967, he presented a series of conceptually driven films at the discotheque L.S.D. in Tokyo. Together with Rikuro Miyai, he began presenting film in Tokyo jazz clubs, such as Pit Inn and Noa Noa as well as at events organised by the Art Film Association in Kyoto and Osaka. As a participant of the Intermedia Art Festival at the discotheque Killer Joe’s, Tokyo, in 1969, Gulliver presented ​Cinematic Illumination​ (1968–69), a work involving eighteen slide projectors that illuminated the unique 360-degree environment. The outdoor performance ​Flying Focus ​(1969) involved a tubular balloon into which Gulliver projected coloured patterns using an overhead projector. Since, he has continued to remain active as an artist working in the fields of sculpture, performance and new media with an interest in the body, scale, and humour. He is represented by Tajana Pieters (Ghent) and Aoyama Meguro (Tokyo) and has performed or exhibited his work recently at Tate Modern and Tokyo Photographic Art Museum.
      ],
      description_jp: %Q[
        シュウゾウ・アヅチ・ガリバー(Shuzo Azuchi Gulliver、1947年生、滋賀県出身)、複 数の表現領域で活動するアーティスト。高校時代、アーティスト集団The Play、れまん だらんを結成、京都と大阪でコンセプチュアルな路上パフォーマンスを上演する。 1960年代後半、東京と関西を往復して暮らすなか、メディアの注目を集め、ヒッピー (フーテン)現象の代表的な人物となる。アーティスト名として今でも使われている" ガリバー"はその当時のあだ名。 1967年、東京のディスコ「L.S.D」にてコンセプチュ アルなフィルム作品を発表する。宮井陸郎と共に、「ピットイン」や「ノアノア」と いった東京のジャズクラブや、京都と大阪での「映像芸術の会」が主催するイベントに てフィルム作品を発表。1969年には東京のディスコ「キラー・ジョーズ」(Killer Joe's )でのインターメディア・アート・フェスティバルに参加、18台のスライドプロジェ クターが独自の360度スクリーンに映像を投映する作品「Cinematic Illumination」( 1968-69)を発表。また、野外パフォーマンス「Flying Focus」(1969)では、オーバー ヘッドプロジェクターを使用し、管状の風船に色彩模様を投映した。以来、「身体」、 「スケール」、「ユーモア」への関心を持ちながらアーティストとして彫刻、パフォー マンス、ニューメディアの領域で活動を続ける。ギャラリーTajana Pieters(ゲント)及 び青山目黒(東京)所属。近年、テートモダン、東京写真美術館にてパフォーマンス、 展覧会を開催。
      ]
    },
    {
      name_en: "OE Masanori",
      name_jp: "おおえまさのり",
      description_en: %Q[
        Masanori Oe (b. 1942) is a filmmaker, writer and translator. Moving to New York in his early twenties, between 1965 and 1968, he became involved in the Third World Studios together with Stan VanDerBeek and Jonas Mekas. Joining Marvin Fishman at Studio M2, Oe began filming protest activities as part of the Newsreel Collective. He participated in USCO’s psychedelic shows and translated his psychedelic experiences into his films ​Between the Frames (1​ 967) and Salome’s Children (​ 1968). Together with Yukihisa Isobe, he participated in the exhibition “Some More Beginnings” by E.A.T. at the Brooklyn Museum in 1968. His work in psychedelic culture and political activism came together in ​Great Society​ (1967), co-directed by Marvin Fishman, a six-screen collage of newsreel footage from the television broadcast company CBS who commissioned them to make it. Upon returning to Japan, he co-founded Newsreel Japan with filmmaker Masato Hara and photographers Takuma Nakahira and Kenji Kanesaka. They joined members of the collective Zero Jigen and others to halt the 1969 edition of Tokyo Film Art Festival at Sogetsu Art Centre on the grounds that the film festival’s competition format encouraged a hierarchy among films, an act that was met with controversy. He followed the collective Zero Jigen to shoot their film ​White Hare of Inaba​ (1970). He translated ​The Tibetan Book of the Dead,​ published in Japanese by Kodansha in 1974, and wrote extensively on his LSD experiences. He helped to found one of the first health-food stores in Japan and became an organic farmer. His works have recently been presented at Museum of Modern Art, Tate Modern, and Tokyo Photographic Art Museum.
      ],
      description_jp: %Q[
        おおえまさのり(1942年生)映像作家、作家、翻訳家。 二十代前半1965年から1968年 の間、ニューヨークに移住、スタン・ヴァンダービーク、ジョナス・メカスと共に「 Third World Studios」に参加。スタジオM2にてマーヴィン・フィッシュマンと共同し、 Newsreel Collectiveの一環として抗議活動の撮影を開始。また、USCOが企画したサイケ デリックイベントに参加、自らの幻覚体験を「Between the Frames」(1967)、「 Salome's Children」(1968)といった作品に表現する。1968年、ブルックリン美術館で のE.A.T.主催「Some More Beginnings」展に磯辺行久と共に参加。また、サイケデリッ ク文化と政治的アクティヴィズムにおける彼の仕事の結集である「Great Society」 (1967)は、放送ネットワークCBSより製作を委嘱され、マーヴィン・フィッシュマンと 共同監督し、CBSのニュース映像による6面スクリーンを使ったコラージュ作品であ る。帰国後、映像作家の原正人、写真家の中平卓馬、金坂健二と共にNewsreel Japanを 発足。また、集団「ゼロ次元」のメンバーらと共闘、主催者によるコンペ形式の採用が 映画のヒエラルキー化を助長することに抗議、草月アートセンターでの「フィルム・ アート・フェスティバル1969東京」を中止に追い込む。「ゼロ次元」に同行し、映画 「いなばの白うさぎ」(1970)を撮影。『チベットの死者の書』を邦訳し、1974年、講 談社から出版される。LSD体験に関する文章多数。日本初の健康食品店の設立を援助 し、有機栽培農家となる。近年ニューヨーク近代美術館(MoMA)、テートモダン、東 京都写真美術館で作品を発表。
      ],
    },
    {
      name_en: "IIMURA Takahiko",
      name_jp: "飯村隆彦",
      description_en: %Q[
        Takahiko Iimura (b. 1937, Tokyo) is an artist and filmmaker who has lived between Tokyo and New York throughout his artistic career. Together with Nobuhiko Obayashi and Yoichi Takabayashi, Iimura was one of the first to organize screenings of 8mm films outside of amateur home movie circles, in the early 1960s. Presenting screenings at gallery spaces, including the first in a series of Naiqua Cinematheque screenings held at Naiqua Gallery, Tokyo, in 1963, Iimura’s peers mostly consisted of artists rather than filmmakers, which led to several collaborations: Yoko Ono created the sound design of ​Ai (Love) ​(1962-63); Natsuyuki Nakanishi co-directed ​On Eye Rape​ (1963), an early Japanese found footage film; and Sho Kazakura performed happenings for the camera in ​Dance Party in the Kingdom of Lilliput ​(1964). These collaborations influenced the way Iimura presented his films, which led to his early experiments in expanded cinema and, eventually, film and video installations. After winning a group prize at the experimental film festival EXPRMNTL in Knokke-le-Zoute, Belgium, in 1963, Iimura co-founded the group Film Independents with the other recipients. Encouraged by a positive review of his film ​Ai (Love)​ by Jonas Mekas, Iimura relocated to New York in 1966 where he initiated further collaborations, such as with Alvin Lucier. Returning to Tokyo in 1969, Iimura began immersing himself in video art and, ever since, has been considered a pioneer of expanded cinema, video art and film installation in Japan. His works have been presented at Centre Pompidou, Museum of Modern Art, Tokyo Photographic Art Museum, and Eye Filmmuseum.
      ],
      description_jp: %Q[
        飯村隆彦(1937年生、東京出身)は、東京とニューヨークを拠点に活動するアーティス ト、映像作家。1963年、日本のネオ・ダダの前衛画廊であった、内科画廊での最初の個 展上映を「内科シネマテーク」として始め、また、画家、中西夏之や音楽家、刀根康尚 らのアーテイストと「フィルム・アンデパンダン」を組織、紀伊国屋ホールで上映す る。 アーティストとの交流が多かったことから、小野洋子による 「Ai (Love)」( 1962-63)の音楽、日本における初期ファウンド・フッテージフィルムにパンチを連続 して空けたパフォーマンス「視姦について」(1963)を中西夏之と共同制作。さらに 「リリパッド王国舞踏会」(1964年)では主演の風倉匠によるパフォーマンスを演出す る。これらのコラボレーションは、飯村の作品の上映方法を拡大して、のちの拡張映画 の前例となり、その後の映画やビデオ・インスタレーションへと発展する。 1964年、 ベルギーのクノック・ル・ズーの実験映画祭「EXPRMNTL」では「オナン」が特別賞 を受賞。1966年には、「Ai」(Love)がジョナス・メカスによりビレッジ・ボイス紙 に高く評価され、さらにハーバード大學の国際セミナーの招待により、渡米、ニュー ヨークに移住する。音楽のアルヴァン・ルシエとニューヨークのDomなどで「シェル ター9999」をライブ公演する。1969年からビデオアートを始め、「タイム3部作」( 1973)や「オブザーバー/オブザーブド」(1976)「ビデオの記号学」(1975-1976)な どビデオ固有のテーマを制作する。ベルリンの以来、拡張映画、ビデオアート、ビデオ インスタレーションにおける先駆的アーティストとしてパのポンピドゥセンター、 ニューヨーク近代美術館(MoMA)、東京都写真美術館などにて作品を展示, 上映し、 収蔵作品ともなっている。
      ]
    },
    {
      name_en: "TANAAMI Keiichi",
      name_jp: "田名網敬一",
      description_en: %Q[
        Tanaami Keiichi (b. 1936, Tokyo) is an artist, graphic designer and animation filmmaker. While still a student at the Mushashino Art University, his career took off when he received a special selection award at the 1958 Japan Advertising Art Exhibition. He participated in the Animation Festival at Sogetsu Art Center in 1965 and 1966, after which his animation works frequently screened at international film festivals such as International Short Film Festival Oberhausen, New York Film Festival and Ottawa International Animation Festival. Tanaami became known as a leading figure of pop art and psychedelic art in Japan as his 2D works featuring print methods such as silkscreen and collage, sculptural works, and films grew increasingly popular in the 1960-70s. Designing record covers, posters, and taking on the role of Art Director for the Japanese edition of PLAYBOY in 1975, he often bridged commercial work and art practice ––it was just as likely to see his work on a magazine cover as an art exhibition. Now represented by NANZUKA, his career continues to be as prolific as ever with works exhibited recently at Walker Art Center, Museum of Modern Art (New York), Hamburger Bahnhof, and Tate Modern.
      ],
      description_jp: %Q[
        田名網敬一(1936年、東京出身)は、東京を拠点に活動するアーティスト、グラフィックデザイナー、映像作家。1958年、武蔵野美術大学の学生であった当時に日宣美展にて特別選考賞を受賞し、作家活動を始める。 1965年、1966年、草月アートセンターでのアニメーションフェスティバルに参加し、その後、オーバーハウゼン国際短編映画、ニューヨーク映画祭、オタワ国際アニメーションフェスティバルなどの国際映画祭へも多数参加している。1960-70年代にかけて、シルクスクリーンやコラージュなどの印刷を活用した平面作品、立体作品、映像作品が評価され、日本におけるポップアート、サイケデリックアートの先駆的アーティストとして知られるようになる。一方、レコードのジャケットやポスター等のデザインも手掛け、1975年には日本版『PLAYBOY』のアートディレクターに就任。デザインの枠を超えたアート作品ともいえるその表紙が世に広まり、アートと商業芸術の架橋をつくる上で大きく貢献した。現在、東京のアートギャラリーNANZUKAに所属し、今尚多くの新作を発表し、近年、ウォーカー・アート・センター、ニューヨーク近代美術館(MoMA)、ハンブルガー・バーンホフ、テート・モダンなど、世界的に著名な美術館で作品が展示されている。
      ]
    },
    {
      name_en: "MANABE Hiroshi",
      name_jp: "真鍋博",
      description_en: %Q[
        Born in Uma-gun (now Niihama-shi), Ehime prefecture, MANABE Hiroshi (1932–2000) was an illustrator, animator, and essayist. He graduated from the department of oil painting at Tama Art University in 1954. At the early stage of his career, he began to show his works at the Nikikai Exhibition and in the Yomiuri Independent Exhibition (also known as Yomiuri Independents). Together with artists Ikeda Masuo, Horiuchi Kōji, and others, Manabe formed a group—”Existentialists,” or “Jitsuzai-sha”—in 1955. Besides oil paintings, he experimented with other genres such as manga illustrations, animation, stage art, etc. In 1960, he received the first Kodansha Sashie Prize for his illustrations of science fiction novel ​The Seventh Underground.​ His artistic versatility included works in abstract and futuristic styles as his interest shifted from oil paintings. In 1960, he formed “A Club of Three Animators” (Anemēshon Sannin no Kai) with Kuri Yōji and Yanagihara Ryōhei. The group presented independent animation works at Sōgetsu Art Center in the 1960s. Manabe’s experimental work ​Three-Persons Animation​ (Sannin no Anemēshon) combined projected animation, Noh stage performance, and lighting.
      ],
      description_jp: %Q[
        真鍋博(1932年- 2000年、愛媛県出身)イラストレーター、アニメーション作者、 エッセイスト。 1954年多摩美術大学油絵科を卒業し、二紀会展、読売アンデ パンダン 展などに出品した。1955年に池田満寿夫、堀内康司らと共に「実存者」グループを結成 した。油絵の他に、漫画、アニメ、舞台芸術などのジャンルで活動を行い、1960年には SF小説「第七地下壕」の挿絵で講談社さしえ賞を受けた。1960年に久里洋二と柳原良 平と共に「3人のアニメータの会」を結成し、1960年代に草月アートセンターで実験ア ニメーション作品を上映した。真鍋の実験作品「三人アニメーション」は、アニメー ション、能パフォーマンス、照明を組み合わせたものである。
      ]
    },
    {
      name_en: "JONOUCHI Motoharu",
      name_jp: "城之内元晴",
      description_en: %Q[
        JONOUCHI Motoharu (1935–1986) was a film director working at the intersection of politics and avant-garde art. Together with Katsumi Hirano, Hiroshi Kanbara, Yasuhiro Taniyama Motoharu, and Masao Adachi, Jonouchi established the Cinema Club in the College of Art at Nihon University (Nichidai Eiken) in 1957. At the Cinema Club, he directed ​N no kiroku (Documents of N, 1959), and ​PuPu​ (1960). In 1961, Jonouchi was among a group of film directors, with Masao Adachi and Hiroshi Kanbara, who founded the Van Film Science Research Center as a place for artistic production outside of the university. His interdisciplinary collaboration with various avant-garde artists resulted in the production of such works as Document 6. 15 ​(1961), ​Shelter Plan​ (1964), ​WOLS​ (1964-69), ​Gewaltopia Trailer​ (1969), and Shinjuku Station ​(1974). Jonouchi died before completing his final work, ​Ainu Moshiri e no michi​ (The Road to Ainu Mosir), that he had started in 1977.
      ],
      description_jp: %Q[
        城之内元晴(1935-1986)の作品は政治と前衛芸術の交点に取り組んだ。 1957年、平野 克己、神原寛、谷山(康)浩郎、足立正生と一緒に、日本大学芸術学部映画研究会(日 大映研)を設立した。 日大映研で、「Nの記録」(1959)、と「PuPu」(1960)など を制作した。1961年には大学外での芸術作品の制作場所としてVAN映画科学研究所を 設立した。主な代表作品に「ドキュメント6・15」(1961)、ハイレッドセンター・ シェルタープラン」(1964)、「WOLS」(1964-69)、「ゲバルトピア予告編」(
  1969)、新宿ステーション(1974)などがある。 城之内は1977年に制作を始めた最終 作品「アイヌモシリへの道」を完成しないまま世を去った。
      ]
    }, 
    {
      name_en: "Michio Okabe",
      name_jp: "",
      description_en: %Q[
        Michio Okabe (1937-2020) began his activities as an artist in the mid-1960s, participating in the contemporary artist group Off Museum. He interacted with groups such as Neo-Dada and Hi Red Center, as well as artists like Ushio Shinohara, and presented at Yomiuri Independent exhibition (1964), Big Fight exhibition (1965), a solo exhibition at Naiqua Gallery (1965), as well as street performances. Influenced by Kenneth Anger’s Scorpio Rising (1963), Okabe made his first film work Tenchi Sozosetsu (creation tale, 1965), which received a prize at the Sogetsu experimental film festival. Thereafter he made Crazy Love (1968), Camp (1970), Shiroyo Dokoe Iku (Shiro, where are you going, 1970), Shonen Shiko (1973, won a grand prize at Knokke-le-Zoute International Film Festival), Saijiki (1973), and Kaisoroku (1977). The works that sublimate Susan Sontag’s thinking on camp into Okabe’s original camp aesthetic, have been highly received and have screened in Japan and abroad. Besides film production, Okabe published fantastical short stories through reading programs on radio, magazines, fantasy literature anthologies, as well as his own book. Okabe passed away in September, 2020.
      ],
      description_jp: %Q[]
    },
    {
      name_en: "CTG (Computer Technique Group)",
      name_jp: "",
      description_en: %Q[
        CTG was founded by Masao Komura, Haruki Tsuchiya, Kunio Yamanaka, and Junichiro Kakizaki in December of 1966. These four founding members were later joined by Koji Fujino, Fujio Maruha, Makoto Otake, Takeshi Hasegawa, Shigeaki Iwashita, and Michio Sasaki. With the cooperation of Japan IBM, the group utilized a large-scale calculator and plotter to create cutting-edge computer art. In 1968, the group participated in the Cybernetic Serendipity exhibition at the ICA London, which featured computer art in the context of contemporary art. That year the group also won the 6th annual computer art contest held by the American magazine Computers & Automation, and was featured in the publication. In November of 1969, CTG disbanded; Komura Masao continues his work in media art.
      ],
      description_jp: %Q[]
    },
    {
      name_en: "Morihiro Wada",
      name_jp: "和田守弘",
      description_en: %Q[
        Morihiro Wada (1947-2007) was born in Takamatsu City, Kagawa Prefecture in 1947. He graduated from Tama Art University, Department of Painting, Oil Painting Course in 1973. He met the Canadian video artist, Michael Goldberg in 1971, and began making video works and participating in the collective Video Hiroba. In the 1970s, he produced single channel video and many conceptual works that incorporated video into his performance. His film and video work explores phenomenological structures. He continued to produce works in various ways of expression such as video, photograph, painting, drawing, sculpture, installation, performance, among others.
        Solo presentations include series exhibitions held almost every year from 1971 through 2001, including The Revelations About Nature, Introduction on Methods from Recognition, Aplicación, The Recognition Construction, Hyojyutsu, and others. Major exhibitions include The 6th Japan Art Festival (1971, The National Museum of Modern Art, Tokyo, and others), Do It Yourself Kit (1972, Ginza Sony Building, Tokyo), Tokyo-New York Video Express (1974, Tenjo-Sajiki-Kan, Tokyo), Video Art (1975, The Art Institute of Chicago, Chicago), Artists Today (1979, Yokohama Civic Art Gallery, Kanagawa), Operation Equinox (1981, Centre Pompidou, Paris), The New Video Japan (1986, The Museum of Modern Art, New York), Introduction to Art History: Films by Contemporary Japanese Artists (1988, Meguro Museum of Art, Tokyo), Encountering the Others: The Kassel International Art Exhibition (1992, various sites,Hann. Münden and Kassel), Video-New World(1993, O Art Museum, Tokyo), and Exhibition Commemorating Yoshiaki Tono: Water Always Flows Together (2006, Gallery Tom, Tokyo). In 2009, his retrospective exhibition, Morihiro Wada: The Trajectory of Artist Who Ran Through 1967-2006 was held at Kanagawa Kenmin Hall Gallery.
        Since then, exhibitions include Vital Signals – Early Japanese and American Video Art (2009-2010, touring exhibition to Japan Society, New York; Museum of Fine Arts, Boston; Los Angeles County Museum of Art; Yokohama Museum of Art; The National Museum of Art, Osaka and other locations), Yebisu International Festival for Art & Alternative Visions 2015 (2015, Tokyo Photographic Art Museum, Tokyo) MAM Research 004: Video Hiroba Reconsidering Experimental Video Groups in the 1970s (2016, Mori Art Museum, Tokyo) Japan Sound Archive―Morihiro Wada <<An Introduction to Methods in Cognition No.Ⅰ Self musical >> 1973 (Art & Space Cococara, Tokyo).   
      ],
      description_jp: %Q[
        1947年、香川県高松市に生まれる。1973年、多摩美術大学絵画科油画専攻卒業。71年にカナダのヴィデオ作家マイケル・ゴールドバーグと出会ったことをきっかけにヴィデオを用いた作品の制作を始め、「ビデオひろば」に参加した。そうして和田は、1970年代を通してシングルチャンネルのヴィデオや、パフォーマンスを取り込んだヴィデオインスタレーションを多数発表してゆく。和田のフィルムやヴィデオは、知覚の認知構造を探るコンセプチュアルなものであり、それは当時の美術家の問題意識に根ざしていた。ヴィデオ、写真、絵画、ドローイング、彫刻、インスタレーション、パフォーマンスなどさまざまな表現手段で発表を続けた。
        個展は、1971年から2001年まで、ほぼ毎年行った。「自然に於ける黙示禄」「認識からの方法序説」「アプリカシオン」「認知構造」「表述」「表基」等のシリーズがある。主なグループ展に「第6回 ジャパン・アート・フェスティバル」（1971年、東京国立近代美術館、東京他）、「Do It Yourself Kit」（1972年、銀座ソニービル、東京）、「Tokyo-New York Video Express」（1974年、天井桟敷館、東京）、「Video Art」（1975年、シカゴ美術館、シカゴ他）、「今日の作家展」（1979年、横浜市民ギャラリー、神奈川）、「エキノックス大作戦」（1981年、ポンピドー・センター、パリ）、「The New Video Japan」（1986年、ニューヨーク近代美術館、ニューヨーク）、「美術史探索学入門―現代美術としての映像表現」（1988年、目黒区美術館、東京）、「他文化との遭遇」（1992年、会場多数、ハン・ミュンデン／カッセル、）、「ビデオ・新たな世界」（1992年、Ｏ美術館、東京）、「水はつねに複数で流れる―東野芳明を偲ぶオマージュ展」（2006年、ギャラリーTOM、東京）。
        2009年に回顧展「和田守弘展―走り去った美術家の航跡 1967-2006」（神奈川県民ホールギャラリー）が開催された。
        「Vital Signals：日米初期ビデオアート」（2009−2010年、Electronic Arts Intermix (New York), 横浜美術館共催、ジャパン・ソサイティ（ニューヨーク）、国立国際美術館（大阪）他）、「第7回恵比寿映像祭」（2015年、東京都写真美術館、東京）「MAMリサーチ004:ビデオひろばー1970年代の実験的映像グループ再考」(2016年　森美術館、東京)「日本サウンドアーカイヴー和田守弘《認識に於ける方法序説　№ⅠSELF・MUSICAL》1973年」(Art＆Space ここから、東京)
      ]
    },
    {
      name_en: "Mako Idemitsu",
      name_jp: "",
      description_en: %Q[
        Born in a patriarchal family in Japan, Mako Idemitsu's works explore her inner struggle and identity as a woman, wife, daughter, mother, and a foreigner looking for a home abroad. After having two children in California with artist Sam Francis, Idemitsu took up a Super 8 film camera. The 1972 Woman’s House is a document of her visit to Judy Chicago and Miriam Schapiro's Womanhouse, a feminist art installation and performance space. In the same year Idemitsu made Inner-Man, her first work featuring a Jungian inner persona, a theme and style she continues to explore. In the work, Idemitsu overlays images of a naked man over a woman in kimono, suggesting the inner man in a woman. A beautiful picture of her lonely sentiments of living abroad, Santa Monica 3 (1974) shines light on Idemitsu’s filmic lyricism. Emotional Volatility about My Father (1981) illustrates her tangled relationship with her father, who had disowned her when she chose to remain in California. Great Mother (SACHIKO) (1985) is a typical representation of what is known as "Mako-style," in which the physical monitor placed in the shot represents a psychological other that inflicts internal conflict within the protagonist.
        ],
      description_jp: %Q[]
    },
    {
      name_en: "Michio Okabe",
      name_jp: "",
      description_en: %Q[
        Michio Okabe (1937-2020) began his activities as an artist in the mid-1960s, participating in the contemporary artist group Off Museum. He interacted with groups such as Neo-Dada and Hi Red Center, as well as artists like Ushio Shinohara, and presented at Yomiuri Independent exhibition (1964), Big Fight exhibition (1965), a solo exhibition at Naiqua Gallery (1965), as well as street performances. Influenced by Kenneth Anger’s Scorpio Rising (1963), Okabe made his first film work Tenchi Sozosetsu (creation tale, 1965), which received a prize at the Sogetsu experimental film festival. Thereafter he made Crazy Love (1968), Camp (1970), Shiroyo Dokoe Iku (Shiro, where are you going, 1970), Shonen Shiko (1973, won a grand prize at Knokke-le-Zoute International Film Festival), Saijiki (1973), and Kaisoroku (1977). The works that sublimate Susan Sontag’s thinking on camp into Okabe’s original camp aesthetic, have been highly received and have screened in Japan and abroad. Besides film production, Okabe published fantastical short stories through reading programs on radio, magazines, fantasy literature anthologies, as well as his own book. Okabe passed away in September, 2020.
      ],
      description_jp: %Q[]
    }, 
    {
      name_en: "Norio Imai",
      name_jp: "",
      description_en: %Q[Born in 1946 in Osaka, Norio Imai studied under Jiro Yoshihara, founder of Gutai Art Association while attending high school. He was a member of the Gutai group from 1965 until 1972 when the group dissolved. His earliest solo exhibition was Testimony of a 17-Year-Old at Noonu Gallery, Osaka in 1964. The same year, as the youngest member of the Gutai group, he exhibited in the 14th Gutai Art Exhibition when he was 17.
        Imai’s range of practice include painting, printmaking, sculpture, photography, video, and performance. Imai’s slides and films works of the 1960s and ’70s illustrate Imai’s testing of, and his interaction with the new medium of moving image, while his videos of the 1980s document his playful performances.
        Selected solo and group exhibitions include: Testimony of a 17-Year-Old (1964, Noonu Gallery, Osaka), 14th Gutai Art Exhibition (1964, Takashimaya Department Store, Osaka), From Space to Environment (1966, Ginza Matsuya Department Store, Tokyo), Fluorescent Chrysanthemum–Contemporary Japanese Art (1968, ICA, London), Gutai Group Display (1970, Midorikan Pavilion Entrance, Expo’70 World’s Fair, Suita, Osaka), 16th International Short Film Festival Oberhausen (1970, Oberhausen, Germany), 10th Contemporary Japanese Art Exhibition – Man and Nature (1971, Tokyo Metropolitan Art Museum, followed by Kyoto Municipal Museum of Art), Image Expression ’72 - Equivalent Cinema (1972, Kyoto Municipal Museum of Art), From Underground Cinema to Private Films (1978, Tokyo Metropolitan Art Museum), Norio Imai – Videotape Performance (1981, Video Gallery SCAN, Tokyo), Video Cocktail III (1986, Hara Museum of Contemporary Art, Tokyo), Radical Communication: Japanese Video Art 1968-1988 (2007, The Getty Center, Los Angeles), Vital Signals – Early Japanese and American Video Art (2009-2010, touring exhibition to Japan Society, New York; Museum of Fine Arts, Boston; Los Angeles County Museum of Art; Yokohama Museum of Art; The National Museum of Art, Osaka and other locations), Gutai: Splendid Playground (2013, Solomon R. Guggenheim Museum, New York), Severed Film / Jointed Film (2017, Gallery Joey Ramone, Rotterdam), White Event x moving images 1966 – 2016 (2016, Yumiko Chiba Associates viewing room Shinjuku), Norio Imai - Action on Film (2019, ARTCOURT Gallery, Osaka), among others.],
      description_jp: %Q[],
    },
    {
      name_en: "Keiji Uematsu",
      name_jp: "",
      description_en: %Q[
        Born in 1947 in Hyogo Prefecture, Keiji Uematsu graduated from the department of Fine Arts, Kobe University in 1969 and moved to Germany in 1975. Since 1986 he has resided and worked in both Minoo city, Japan, and Düsseldorf, Germany. Uematsu has exhibited works illustrating relationships between the body and objects, and has pursued strategies to render visible, unseen forces, such as gravity and magnetism, and reveal the underlying structure. The use of natural materials such as wood, stone, fabric, and metal, as well as the fact that his activities were contemporaneous to the prolific artists associated with the movement Mono-ha, give a false notion that his work is also connected to the movement. Instead of attention to the inherent state of natural and industrial materials, and their relation to the environmental space surrounding them, Uematsu’s focus is on expose the structures and relationships of the physical world that may not be visible. Since the 1970s, Uematsu began making film and video works. There were a number of fine artists at the time who took the moving image to create conceptual works. This was not a mere documentation of their performances but a strategy to visualize their practice and process. Within this movement, Uematsu produced important works and presented in the annual fine artists’ moving image exhibition in Tokyo, Exhibition of Contemporary Plastic Art: Expression in Film, as well as broadcast a collaborative work, Image of Image—Seeing with artist Tatsuo Kawaguchi and Saburo Murakami at NHK Kobe.
        Major solo exhibitions include Relation of Matters (Galerie 16, Kyoto, 1974), Keiji Uematsu: Skulptur Foto Video Film (Moderna Museet Stockholm, 1976-77), Series, Today’s Artist, Installation and Photo (Osaka Contemporary Art Center, 1981), Keiji Uematsu: eyes under physical consideration - photographs, videos and films 1972-2003 (Kitakyushu Municipal Museum of Art, Fukuoka, 2003), and Keiji Uematsu: The Garden of Time (Otani Memorial Art Museum, Nishinomiya City, Hyogo, 2006). Major group exhibitions include Photography in Contemporary Art (The National Museum of Modern Art, Tokyo, and elsewhere, 1983-84), the 43rd Venice Biennale, Japan Pavilion (1988), and Performing for the Camera (Tate Modern, London, 2016).
      ],
      description_jp: %Q[]
    },
    {
      name_en: "Zero Jigen",
      name_jp: "ゼロ次元",
      description_en: %Q[
        Zero Jigen (Zero Dimension) was an avant-garde arts group formed in Nagoya in the early 1960s, with Yoshihiro Katō and Shinichi Iwata as its core members. Beginning with Haitsukubari kōshin (Crawling Procession), staged in January 1963 in the Sakae district of Nagoya, over a long period of time they executed an extraordinary number of performances known as “Rituals” in Tokyo and elsewhere. These took place on the streets and at various public sites with many people coming and going – at a public bath, on a train, at a shrine, in a cemetery, at a May Day (International Workers’ Day) event – and the group expressed ideas and generated situations by exposing their bodies to society at large, rather than limiting their activities to conventional art venues such as museums and galleries. Their performances simultaneously incorporated items embodying indigenous Japanese customs and rituals, such as sticks of incense, futons, and auspicious red-and-white ropes, and those representing the West such as hats, suits, and walking sticks, capturing Japan’s current state during an era of rapid, ever-accelerating economic growth.
        The group was also aligned with the burgeoning underground film movement, and its members appeared in many works by avant-garde filmmakers, including Miyai Rikuro’s Phenomenology of the Zeitgeist, Okabe Michio’s Crazy Love, Donald Richie’s Cybele, Kanai Katsu’s The Desert Archipelago, and Matsumoto Toshio’s Funeral Parade of Roses.
        As Expo ’70 Osaka approached, Zero Jigen joined Kokuin (Heralding Shadow) and others in forming Banpaku Hakai Kyōtō-ha (Expo ’70 Destruction Joint-Struggle Group) in opposition to the event. With their naked bodies, they raised a banner of revolt against systems of control by the state and capital.
        In 1970 Katō began directing films, producing The White Hare of Inaba with cinematography by the filmmaker Ōe Masanori, followed by Brahmin, which brought his creative activities to fruition. Throughout the countercultural era of the 1960s, Zero Jigen presented a new vision of an arts collective as a human community.
      ],
      description_jp: %Q[
        ゼロ次元〉は、加藤好弘、岩田信市らを中心として1960年代初頭に名古屋で誕生した前衛藝術集団。1963年1月の名古屋栄町における「はいつくばり行進」を皮切りに、東京や各地で「儀式」と称したパフォーマンスを長期にわたり膨大な回数行なった。その活動の現場は、街頭をはじめ、公衆浴場、電車内、神社、墓地、メーデー会場といった大衆の行き交う場であり、美術館や画廊といった“美術”における既存の作品発表の場に止まらず、社会そのものに肉体を曝すことで表現と状況を発生させた。パフォーマンスには、線香や蒲団、紅白綱といった日本の土着性、祝祭性が表れる物品と、帽子やスーツ、ステッキといった西洋的なイメージを連想させる物品を同時に用いることで、高度経済成長という一方向に加速する時代を共時的に捉えていった。
　      また、アンダーグラウンド・フィルム運動とも呼応し、宮井陸郎『時代精神の現象学』、岡部道男『クレイジー・ラブ』、ドナルド・リチー『シベール』、金井勝『無人列島』、松本俊夫『薔薇の葬列』など、多くの映像作家の作品に出演している。
　      1970年の大阪万博が迫ると、〈ゼロ次元〉は、活動を共にしていた〈告陰〉らとともに〈万博破壊共闘派〉を結成。裸の肉体をもって国家・資本による管理システムに叛旗を翻した。
　      1970年には、加藤が監督となり、撮影に映像作家のおおえまさのりを迎えた『いなばの白うさぎ』、続けて『バラモン』を制作。その活動を映画作品として結実させた。こうして60年代のカウンターカルチャーの時代を経て、〈ゼロ次元〉は「共同体」としての新たなるビジョンを提示していく。    
      ]
    },
    {
      name_en: "Yoshihiro Katō",
      name_jp: "加藤好弘",
      description_en: %Q[
        Yoshihiro Katō (1936-2018) was an artist and one of the founding members, along with Shinichi Iwata, of the avant-garde arts group Zero Jigen (Zero Dimension) in the early 1960s. Beginning with Haitsukubari kōshin (Crawling Procession), staged in January 1963 in the Sakae district of Nagoya, over a long period of time they executed an extraordinary number of performances known as “Rituals” in Tokyo and elsewhere. The impact of these one-time-only happenings was amplified through photographs that ran in mass-media publications such as weekly magazines. The publication of photographs and articles in relatively lowbrow weeklies rather than academic art journals aided the group in transcending the established framework of “art” as a system, and informing the general public of their activities. Thanks to Katō’s media strategy, Zero Jigen became a genre-busting collective of great importance in the Japanese counterculture. In the late 1960s, he teamed up with the groups Kurohata (Black Flag) and Kokuin (Heralding Shadow), and individuals such as Koyama Tetsuo of Vitamin Art, and was active as a gishikiya (ritualist). He was also aligned with the burgeoning underground film movement, and appeared in many works by avant-garde filmmakers, including Miyai Rikurō’s Phenomenology of the Zeitgeist (1967), Donald Richie’s Cybele (1968), Kanai Katsu’s The Desert Archipelago (1969), and Matsumoto Toshio’s Funeral Parade of Roses (1969). As Expo ’70 Osaka approached, Katō joined Kokuin, the film critic Kanesaka Kenji and others in forming Banpaku Hakai Kyōtō-ha (Expo ’70 Destruction Joint-Struggle Group) in opposition to the event. With their naked bodies, they raised a banner of revolt against systems of control by the state and capital. Thereafter, Katō began directing films, producing The White Hare of Inaba (1970) with cinematography by the filmmaker Masanori Ōe, followed by Brahmin (1971-76). His films presenting a vision for a new era, involving the joy of human beings’ inherent Eros and a new mode of “family” that breaks free of feudalistic social constraints, brought his creative activities to fruition. In the 1990s he moved to New York, where he produced paintings informed by the montage technique. After returning to Japan he continued working actively in various locations, and was invited to participate in events including Mediacity Seoul 2014 and Reenacting History: Collective Actions and Everyday Gestures (The National Museum of Modern and Contemporary Art, Korea [MMCA], 2017). Dealing with the theme of Asia, Katō remained an artistic agitator until the end of his life.
      ],
      description_jp: %Q[
        美術家。1960年代初頭、岩田信市らとともに〈ゼロ次元〉を結成。63年1月の名古屋栄町における「はいつくばり行進」を皮切りに、東京や各地で「儀式」と称したパフォーマンスを長期にわたり膨大な回数行なった。その活動を週刊誌などのメディアにグラビア写真で発表することで、一回性のパフォーマンスを増幅させていった。また、それら写真や記事の掲載は美術専門誌ではなく、大衆週刊誌をターゲットとすることで、既成の“美術”制度の枠を越え、一般大衆にまでその活動を知らしめていく。こうした加藤のメディア戦略によって、〈ゼロ次元〉はジャンルを越境し、カウンター・カルチャーにおいて重要なグループとなっていった。60年代後半には、〈クロハタ〉や〈告陰〉、ビタミン・アートの小山哲男らとともに、「儀式屋」として活動を展開する。一方、アンダーグラウンド・フィルム運動とも呼応し、宮井陸郎『時代精神の現象学』（1967年）やドナルド・リチー『シベール』（1968年）、金井勝『無人列島』（1969年）、松本俊夫『薔薇の葬列』（1969年）などの作品に出演していった。70年の大阪万博を前にして、〈告陰〉や映画評論家の金坂健二らとともに〈万博破壊共闘派〉を結成。裸の肉体をもって国家・資本による管理システムに叛旗を翻した。その後、撮影に映像作家のおおえまさのりを迎え、『いなばの白うさぎ』（1970年）を制作。続けて『バラモン』（1971 -76年）を発表。人間が本来もつエロスの悦びや、封建的な社会を脱する新しい「ファミリー」のあり様といった新たな時代のヴィジョンを提示して、その活動を映画作品として結実させた。90年代にはニューヨークへ移住し、モンタージュを意識した絵画制作を継続。帰国後も各地で精力的に活動し、「メディア・シティ・ソウル2014」や「Reenacting History: Collective Actions and Everyday Gestures」（韓国国立現代美術館、2017年）などに招聘され、アジアをテーマに晩年までアジテーションを続けた。
      ]
    },
    {
      name_en: "Arakawa & Madeline Gins",
      name_jp: "",
      description_en: %Q[
        Arakawa (Shūsaku Arakawa; b. 1936, Nagoya, Aichi Prefecture, Japan – d. 2010, New York) was an artist and architect who had a personal and artistic partnership with Madeline Gins that spanned more than four decades. He was one of the founding members of the Japanese avant-garde art collective Neo Dadaism Organizers and exhibited at the Yomiuri Independent exhibition from 1958 to 1961, an annual watershed event for postwar Japanese art. Arakawa arrived in New York in the end of 1961 and quickly rose to fame as one of the earliest practitioners of the international conceptual art movement of the 1960s. He represented Japan in XXXV Venice Biennale (1970) and was included in Documenta IV (1968) and Documenta VI (1977). His work has been shown extensively around the world and is held by numerous museum collections world-wide, including the Metropolitan Museum of Art, New York; Museum of Modern Art, New York; Centre Georges Pompidou, Paris; and the National Museum of Modern Art, Tokyo.
        Madeline Gins (b. 1941, New York – d. 2014, New York) was a poet, writer, and architect. She was a prescient thinker who foresaw the ways in which changes in popular media and technologies would collapse traditional disciplinary and social boundaries and transform everyday life. Much of her intellectual and artistic exploration focused on the body’s relationship to acts of expression as something transformative, rather than merely representational. Her published books include the experimental novel Word Rain (or a Discursive Introduction to the Intimate Philosophical Investigations of G,R,E,T,A, G,A,R,B,O, It Says) (1969); What The President Will Say and Do!! (1984), an excursion into identity, language and free speech using the devices of political rhetoric; and the speculative fiction Helen Keller or Arakawa (1994).
        From the early 1960s, Arakawa and Gins began collaborating on rigorous, philosophical study The Mechanism of Meaning that culminated in the 1997 exhibition Arakawa + Gins: Reversible Destiny at Guggenheim Museum, SoHo, New York. The project demonstrated a constellation of views concerning the nature and representation of meaning, alongside numerous architectural projects that stemmed from their investigations. With the inception of their theory of reversible destiny—the provocation that through radical forms of architecture mortality itself can be undone —they dedicated themselves to rethinking the relationships between our bodies and their architectural environments. They built six architectural works in Japan and New York, notably: the Site of Reversible Destiny—Yoro Park, 1993–95, a 4.5 acre landscape in the mountains of Gifu Prefecture, Japan; Reversible Destiny Lofts Mitaka—In Memory of Helen Keller, 2005, a multi-residential development in Tokyo, Japan; The Bioscleave House (Lifespan Extending Villa), a residence in East Hampton, New York.
        Although Arakawa and Madeline Gins are known primarily for their work in painting, poetry, and architecture, they created two experimental films: Why Not (A Serenade of Eschatological Ecology) (1969) and For Example (A Critique of Never) (1971). Both films premiered at the Whitney Museum of American Art and have been described by film critic and historian Amos Vogel in Film as a Subversive Art as “unquestionably a major work of the American Avant-Garde of the seventies”. The films have been screened at the Sogetsu Art Center (1969), Tokyo, Japan; the Venice Biennale 1978, Venice, Italy; Onnasch Galerie (1971), Cologne, Germany; NTT InterCommunication Center (1998), Tokyo, Japan; Aichi Arts Center (2001), Nagoya, Japan; Yamaguchi Center for Arts and Media (2011), Yamaguchi, Japan; Park Tower Hall Image Forum Festival 2014, Tokyo, Japan; Forum Lenteng (2016), Jakarta, Indonesia; Toyo University (2017), Tokyo, Japan; Kansai University (2018), Osaka, Japan; among other venues.
      ],
      description_jp: %Q[]
    },
    {
      name_en: "Shinichi Iwata",
      name_jp: "岩田信市",
      description_en: %Q[
        Artist Shinichi Iwata (1935-2017) in 1960 joined Kōtarō Kawaguchi, Takayoshi Koiwa and others in forming 0 Jigen, the precursor of the avant-garde arts group Zero Jigen (Zero Dimension). Iwata remained based in his home city of Nagoya while collaborating with Yoshihiro Katō, who had moved to Tokyo, as core members of Zero Jigen. He also played a role in the development of Japan’s underground film movement, acting in Katsu Kanai’s films The Desert Archipelago (1969) and The Kingdom (1973) and producing The Walking Man (1969). After the actions of Banpaku Hakai Kyōtō-ha (Expo ’70 Destruction Joint-Struggle Group), which vehemently opposed Expo ’70 Osaka, came to a close, Iwata participated in a legal battle sparked by the exhibition of garbage artworks by N.A.G. (New Art Group) at the Aichi Prefectural Museum of Art, after which the artists were locked out of the museum. In 1972 he staged the performance Asama-Sansō of Love (Ai no Asama-sansō) in response to the Asama-Sansō hostage crisis and police siege involving the far-left United Red Army, and documented the performance on film. In 1973 he ran for mayor of Nagoya on the “Rainbow Party” ticket, and his activities ran parallel to those of the Japanese hippie scene as well as presenting a unique form of Pop Art that found elements of art in the culture and customs of the general public. Iwata also launched Rock Kabuki “Super Ichiza,” disseminating cultural innovations from a provincial area of Japan, and engaged in diverse artistic activities not only in Nagoya but in various locations in Japan and overseas.
      ],
      description_jp: %Q[
        美術家。1960年、名古屋にて〈ゼロ次元〉の前身である〈０次現〉を川口弘太郎、小岩高義らと結成。地元である名古屋を拠点として、東京に拠点を移した加藤好弘とともに、〈ゼロ次元〉の中心メンバーとして活動した。金井勝『無人列島』（1969年）、『王国』（1973年）では役者として出演し、自身も『THE WALKING MAN』（1969年）を制作するなど、アンダーグラウンド・フィルム運動の展開にも関わっている。大阪万博に反旗を翻した〈万博破壊共闘派〉の活動以後、70年にはN・A・G（ニュー・アート・グループ）が愛知県文化会館美術館でゴミ作品を展示し、美術館側からロックアウトを受けたことで始まった裁判闘争に参加。また、あさま山荘事件に応答したパフォーマンス『愛の浅間山荘』（1972年）を名古屋大学で実演、映像作品として記録した。73年にはレインボー党を掲げて名古屋市長選に出馬し、日本のヒッピーカルチャーに並走するとともに、大衆・風俗から藝術を見出すという独自の「ポップアート」を表していった。さらには、ロック歌舞伎「スーパー一座」を旗揚げして、地方から独自の文化を発信するとともに、名古屋にとどまらず海外公演を行うなど、さまざまな表現活動を展開した。
      ]
    }
  ]
end

def collection_details
  [
    {
      name_en: "TOP Museum",
      name_jp: "東京都写真美術館",
      description_en: %Q[
        Founded in 1990 as the Tokyo Metropolitan Museum of Photography, TOP opened in Tokyo’s Yebisu Garden Place in January 1995. The museum is devoted to collecting, displaying, preserving, studying, and popularizing photography and moving images. Its Image Permanence Laboratory is dedicated to the storage and conservation of photographs. The museum offers exhibitions, lectures and screenings, educational programs, research opportunities, and a library.
      ],
      description_jp: %Q[
        東京都写真美術館は、日本で初めての写真と映像に関する総合的な美術館として、1995 (平成7)年1月に恵比寿ガーデンプレイス内に総合開館。日本における写真・映像文化 の充実と発展を目的として、1990(平成2)年6月の一次施設開館を経て誕生した。
      ],
      website: "https://topmuseum.jp/e/contents/index.html"
    },
    {
      name_en: "Fukuoka City Public Library",
      name_jp: "",
      description_en: %Q[
        Opening its doors to the public on June 29, 1996, the Fukuoka City Public Library, a multi-function facility of the City of Fukuoka promoting the concept of lifelong learning, is comprised of the Library Division, the City Archive Division and the Film Archive Division. There are annexed facilities such as the Movie Hall Cine-la and Mini Theater. With outside parking for up to 300 bicycles and 143 cars, the ferro concrete 5 story building has a capacity to store up to 2 million volumes of paper material including books and magazines and up to 20,000 2,000 ft. reels of 35mm film.
      ],
      description_jp: %Q[
        福岡市総合図書館は、図書資料・映像資料・文書資料の3つの部門からなる福岡市の生 涯学習推進の中枢施設。
      ],
      website: "http://toshokan.city.fukuoka.lg.jp/english/index.htm"
    }
  ]
end
