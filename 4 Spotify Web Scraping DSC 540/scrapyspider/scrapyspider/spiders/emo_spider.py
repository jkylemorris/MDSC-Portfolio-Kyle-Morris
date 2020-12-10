import scrapy
from scrapyspider.items import EmojiSpiderItem

class EmoSpider(scrapy.Spider):
    name = 'emo'
    allowed_domains = ['webfx.com']
    start_urls = ['https://www.webfx.com/tools/emoji-cheat-sheet/',]
    
   # allowed_domains = ['emoji-cheat-sheet.com']
   # start_urls = ['https://www.emoji-cheat-sheet.com',]
    def parse(self, response):
        headers = response.xpath('//h2|//h3')
        lists = response.xpath('//ul')
        all_items = []
        for header, list_cont in list(zip(headers, lists)):
            section = header.xpath('text()').extract()[0]
            for li in list_cont.xpath('li'):
                item = EmojiSpiderItem()
                item['section'] = section
                spans = li.xpath('div/span')
                if len(spans):
                    link = spans[0].xpath('@data-src').extract()
                    if link:
                        item['emoji_link'] = response.url + link[0]
                    handle_code = spans[1].xpath('text()').extract()
                else:
                    handle_code = li.xpath('div/text()').extract()
                if handle_code:
                    item['emoji_handle'] = handle_code[0]
                all_items.append(item)
        return all_items
                   