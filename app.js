const express = require('express');
const app = express();
const PORT = process.env.PORT || 8080;

// Health check endpoint for Kubernetes probes
app.get('/health', (req, res) => {
  res.status(200).json({ status: 'healthy' });
});

// Readiness check endpoint
app.get('/ready', (req, res) => {
  res.status(200).json({ status: 'ready' });
});

// Main endpoint - Hello World
app.get('/', (req, res) => {
  res.status(200).send(`
    <!DOCTYPE html>
    <html>
    <head>
      <title>Kubernetes Lab</title>
      <style>
        body {
          font-family: Arial, sans-serif;
          display: flex;
          justify-content: center;
          align-items: center;
          min-height: 100vh;
          margin: 0;
          background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .container {
          text-align: center;
          background: white;
          padding: 40px;
          border-radius: 10px;
          box-shadow: 0 10px 25px rgba(0,0,0,0.2);
        }
        h1 {
          color: #333;
          margin: 0 0 10px 0;
        }
        .pod-info {
          color: #666;
          font-size: 14px;
          margin-top: 20px;
          padding: 15px;
          background: #f5f5f5;
          border-radius: 5px;
          font-family: monospace;
        }
        .status {
          color: #4CAF50;
          font-weight: bold;
          margin-top: 15px;
        }
      </style>
    </head>
    <body>
      <div class="container">
        <h1>Hello World! 🚀</h1>
        <p>Welcome to the Kubernetes Lab</p>
        <div class="pod-info">
          <p><strong>Pod:</strong> ${process.env.HOSTNAME || 'unknown'}</p>
          <p><strong>Service:</strong> microservice-service</p>
          <p><strong>Namespace:</strong> default</p>
          <p><strong>Time:</strong> ${new Date().toISOString()}</p>
        </div>
        <div class="status">
          ✓ Application is running
        </div>
      </div>
    </body>
    </html>
  `);
});

// Simple API endpoint for testing
app.get('/api/info', (req, res) => {
  res.status(200).json({
    app: 'Kubernetes Lab Demo',
    version: '1.0.0',
    pod: process.env.HOSTNAME || 'unknown',
    timestamp: new Date().toISOString()
  });
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
  console.log('Endpoints:');
  console.log(`  http://localhost:${PORT}/           - Hello World page`);
  console.log(`  http://localhost:${PORT}/health     - Health check`);
  console.log(`  http://localhost:${PORT}/ready      - Readiness check`);
  console.log(`  http://localhost:${PORT}/api/info   - API info`);
});
