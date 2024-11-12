'use client'

import { useState } from 'react'
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { Progress } from "@/components/ui/progress"
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table"
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card"

export default function WebScraper() {
  const [proxyUrl, setProxyUrl] = useState('https://www.croxyproxy.com/')
  const [targetUrl, setTargetUrl] = useState('https://51.159.194.250/__cpi.php?s=UkQ2YXlSaWJuc3ZoeGR2dG04WW9Lbks2VWFPN1NiRmVTTkpXL0hNTnZ4N1lCQlZ0MDRBRUtIRFpKR0FBVVpvcmxLK3kyN2IyVW9Qem5zN044Q0dkTk1ZTTB3a3l4RmhXbnlMRjRXK3YrcEU9&r=aHR0cHM6Ly81MS4xNTkuMTk0LjI1MC9zaG9wLXNraW4tY3JlYW1lcnkvP19fY3BvPWFIUjBjSE02THk5emEybHVZM0psWVcxbGNua3VZMjl0&__cpo=1')
  const [chromeDriverPath, setChromeDriverPath] = useState('C:\\Users\\Anony\\Downloads\\chromedriver.exe')
  const [isScrapingActive, setIsScrapingActive] = useState(false)
  const [progress, setProgress] = useState(0)
  const [scrapedData, setScrapedData] = useState([])

  const startScraping = () => {
    setIsScrapingActive(true)
    setProgress(0)
    setScrapedData([])

    // Simulate scraping process
    const totalSteps = 10
    let currentStep = 0

    const scrapeInterval = setInterval(() => {
      currentStep++
      setProgress((currentStep / totalSteps) * 100)

      // Simulate adding scraped data
      setScrapedData(prevData => [
        ...prevData,
        {
          url: `https://example.com/product-${currentStep}`,
          image: `https://example.com/image-${currentStep}.jpg`,
          title: `Product ${currentStep}`,
          price: `$${(Math.random() * 100).toFixed(2)}`,
          description: `This is a description for Product ${currentStep}`,
          ingredients: `Ingredient A, Ingredient B, Ingredient C`
        }
      ])

      if (currentStep === totalSteps) {
        clearInterval(scrapeInterval)
        setIsScrapingActive(false)
      }
    }, 1000)
  }

  const exportToCsv = () => {
    const csvContent = "data:text/csv;charset=utf-8," 
      + "URL,Image,Title,Price,Description,Ingredients\n"
      + scrapedData.map(row => Object.values(row).join(",")).join("\n")

    const encodedUri = encodeURI(csvContent)
    const link = document.createElement("a")
    link.setAttribute("href", encodedUri)
    link.setAttribute("download", "product_details.csv")
    document.body.appendChild(link)
    link.click()
    document.body.removeChild(link)
  }

  return (
    <Card className="w-full max-w-4xl mx-auto">
      <CardHeader>
        <CardTitle>Web Scraper</CardTitle>
        <CardDescription>Enter the required information and start scraping</CardDescription>
      </CardHeader>
      <CardContent>
        <form className="space-y-4">
          <div>
            <Label htmlFor="proxyUrl">Proxy URL</Label>
            <Input 
              id="proxyUrl" 
              value={proxyUrl} 
              onChange={(e) => setProxyUrl(e.target.value)}
              placeholder="Enter proxy URL"
            />
          </div>
          <div>
            <Label htmlFor="targetUrl">Target URL</Label>
            <Input 
              id="targetUrl" 
              value={targetUrl} 
              onChange={(e) => setTargetUrl(e.target.value)}
              placeholder="Enter target URL"
            />
          </div>
          <div>
            <Label htmlFor="chromeDriverPath">Chrome Driver Path</Label>
            <Input 
              id="chromeDriverPath" 
              value={chromeDriverPath} 
              onChange={(e) => setChromeDriverPath(e.target.value)}
              placeholder="Enter Chrome driver path"
            />
          </div>
        </form>
        
        <div className="mt-6">
          <Button onClick={startScraping} disabled={isScrapingActive}>
            {isScrapingActive ? 'Scraping...' : 'Start Scraping'}
          </Button>
        </div>

        {isScrapingActive && (
          <div className="mt-4">
            <Progress value={progress} className="w-full" />
          </div>
        )}

        {scrapedData.length > 0 && (
          <div className="mt-6">
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>Title</TableHead>
                  <TableHead>Price</TableHead>
                  <TableHead>Description</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {scrapedData.map((product, index) => (
                  <TableRow key={index}>
                    <TableCell>{product.title}</TableCell>
                    <TableCell>{product.price}</TableCell>
                    <TableCell>{product.description}</TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          </div>
        )}
      </CardContent>
      <CardFooter>
        {scrapedData.length > 0 && (
          <Button onClick={exportToCsv}>Export to CSV</Button>
        )}
      </CardFooter>
    </Card>
  )
}
