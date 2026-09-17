# PLBG 工具箱（plbg-tools）

产品线事业部（PLBG）内部小工具的托管站点。在 WorkBuddy 里做的单机 HTML 工具，
往本仓库 `main` 分支一推送，GitHub Pages 就会**自动重新发布**到公开网页。

> 访问地址：`https://yanggx300214.github.io/plbg-tools/`

## 目录结构

```
plbg-tools/
├── index.html              # 站点首页（工具导航，数据在底部 TOOLS 数组）
├── hello-tool/             # 示例工具：演示单文件离线 HTML + 数据对象分离
│   └── index.html
├── fpy-dashboard/          # （待添加）FPY 看板等
├── .github/workflows/      # 自动部署工作流（push 即发布）
└── .gitignore
```

## 怎么加一个新工具

1. 在根目录新建一个文件夹，例如 `my-tool/`，里面放 `index.html`（单文件离线 HTML，
   数据用 `const DATA = {...}` 与渲染逻辑分离，方便以后替换数据）。
2. 打开根目录 `index.html`，在底部 `TOOLS` 数组里加一项：
   ```js
   { name:"我的工具", tag:"分类", desc:"一句话说明", path:"my-tool/" }
   ```
3. 提交并推送：
   ```bash
   git add .
   git commit -m "feat: 新增 my-tool"
   git push origin main
   ```
4. 等 1 分钟左右，刷新网页即可看到。

## 自动部署原理

`.github/workflows/deploy.yml` 监听 `main` 分支的 push，把整个仓库作为静态站点
部署到 GitHub Pages。**纯静态 HTML 无需构建**，push 即上线。

## ⚠️ 安全提醒（公开仓库）

本仓库为**公开**，任何人都能访问。请勿把内部敏感数据、账号密码、未脱敏的
业务数据提交进来。如需保留真实数据，建议：
- 仅提交脱敏/示例数据；或
- 把真实数据文件加入 `.gitignore`，本地保留即可。

## 首次初始化（只需一次）

```bash
git init
git add .
git commit -m "init: PLBG 工具箱脚手架"
git branch -M main
git remote add origin git@github.com:yanggx300214/plbg-tools.git
git push -u origin main
```

然后在 GitHub 仓库 → Settings → Pages → Source 选择 **GitHub Actions** 即可。
