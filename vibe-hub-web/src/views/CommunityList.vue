<template>
  <div class="community-page">
    <div class="page-header">
      <h2>VIBE 社群</h2>
      <a href="#" class="post-btn" @click.prevent>发布新灵感</a>
    </div>

    <div class="post-card" v-for="(p, i) in posts" :key="p.id">
      <div class="post-header">
        <div class="avatar-box">
          <img :src="avatarUrl(i)" class="avatar-img" alt="avatar">
        </div>
        <div class="author-info">
          <span class="author-name">{{ p.author }}</span>
          <span class="post-tag">{{ p.title.includes('风光') ? 'Nature & Landscape' : 'Visual Arts' }}</span>
        </div>
      </div>

      <div class="post-title">{{ p.title }}</div>
      <div class="post-content">{{ p.content }}</div>

      <div :class="['post-images', imageClass(i)]">
        <img v-for="j in imageCount(i)" :key="j"
             :src="landscapeImages[(i * 3 + j - 1) % landscapeImages.length]"
             class="post-img" alt="风光摄影"
             @click="openViewer(landscapeImages[(i * 3 + j - 1) % landscapeImages.length])">
      </div>

      <div class="post-footer">
        <div class="footer-item" @click="handleLike(p.id)">
          <i class="fa-regular fa-heart"></i> {{ p.likes }} 赞
        </div>
        <div class="footer-item"><i class="fa-regular fa-comment"></i> 交流</div>
        <div class="footer-item"><i class="fa-regular fa-share-from-square"></i></div>
      </div>
    </div>

    <!-- Image Viewer -->
    <div :class="['image-viewer', { active: viewerActive }]" @click="closeViewer">
      <span class="close-viewer">&times;</span>
      <img :src="viewerSrc" class="viewer-img" @click.stop>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { getPostList, likePost } from '../api/community'

const posts = ref([])
const viewerActive = ref(false)
const viewerSrc = ref('')

const landscapeImages = [
  'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=1200',
  'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=1200',
  'https://images.unsplash.com/photo-1511497584788-876760111969?w=1200',
  'https://images.unsplash.com/photo-1519904981063-b0cf448d479e?w=1200',
  'https://images.unsplash.com/photo-1495616811223-4d98c6e9c869?w=1200',
  'https://images.unsplash.com/photo-1470770841072-f978cf4d019e?w=1200',
  'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=1200',
  'https://images.unsplash.com/photo-1472214103451-9374bd1c798e?w=1200'
]

function avatarUrl(i) {
  return 'https://images.unsplash.com/photo-1470770841072-f978cf4d019e?w=100'
}

function imageCount(i) { return (i % 3) + 1 }

function imageClass(i) {
  const c = imageCount(i)
  if (c === 1) return 'single-image'
  if (c === 2) return 'two-images'
  return 'multi-images'
}

function openViewer(src) {
  viewerSrc.value = src
  viewerActive.value = true
}

function closeViewer() {
  viewerActive.value = false
}

async function handleLike(id) {
  try {
    const res = await likePost(id)
    const post = posts.value.find(p => p.id === id)
    if (post) post.likes = res.data.likes
  } catch (e) {
    console.error('Like failed', e)
  }
}

onMounted(async () => {
  try {
    const res = await getPostList()
    posts.value = res.data
  } catch (e) {
    console.error('Failed to fetch posts', e)
  }
})
</script>

<style scoped>
:root { --vibe-black: #1d1d1f; --apple-blue: #0071e3; }

.community-page {
  font-family: -apple-system, BlinkMacSystemFont, "SF Pro Display", sans-serif;
  background-color: #f5f5f7; min-height: 100vh;
  display: flex; flex-direction: column; align-items: center; padding-top: 80px;
}

.page-header {
  width: 90%; max-width: 700px; margin-bottom: 50px;
  display: flex; justify-content: space-between; align-items: center;
}
.page-header h2 { font-size: 48px; font-weight: 700; margin: 0; letter-spacing: -2.5px; }
.post-btn {
  background: var(--vibe-black); color: #fff;
  padding: 12px 24px; border-radius: 30px;
  text-decoration: none; font-size: 14px; font-weight: 500; transition: 0.3s;
}
.post-btn:hover { background: var(--apple-blue); transform: scale(1.05); }

.post-card {
  width: 90%; max-width: 700px;
  background: #fff; padding: 40px; border-radius: 32px;
  margin-bottom: 40px; box-shadow: 0 4px 30px rgba(0,0,0,0.03);
  transition: 0.4s cubic-bezier(0.4, 0, 0.2, 1);
}
.post-card:hover { transform: translateY(-8px); box-shadow: 0 20px 50px rgba(0,0,0,0.08); }

.post-header { display: flex; align-items: center; }
.avatar-box { width: 50px; height: 50px; border-radius: 16px; overflow: hidden; margin-right: 18px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); }
.avatar-img { width: 100%; height: 100%; object-fit: cover; }
.author-info { display: flex; flex-direction: column; }
.author-name { font-weight: 700; font-size: 18px; color: #1d1d1f; }
.post-tag { font-size: 11px; color: var(--apple-blue); font-weight: 600; letter-spacing: 1px; margin-top: 4px; }

.post-title { font-size: 28px; font-weight: 700; margin: 25px 0 15px 0; letter-spacing: -1px; line-height: 1.2; color: #1d1d1f; }
.post-content { font-size: 17px; color: #48484a; line-height: 1.8; margin-bottom: 20px; }

.post-images { margin: 25px 0; display: grid; gap: 12px; }
.post-images.single-image { grid-template-columns: 1fr; }
.post-images.single-image .post-img { height: 400px; }
.post-images.two-images { grid-template-columns: repeat(2, 1fr); }
.post-images.two-images .post-img { height: 250px; }
.post-images.multi-images { grid-template-columns: repeat(3, 1fr); }
.post-images.multi-images .post-img { height: 180px; }

.post-img { width: 100%; border-radius: 16px; object-fit: cover; cursor: pointer; transition: 0.3s; box-shadow: 0 2px 15px rgba(0,0,0,0.08); }
.post-img:hover { transform: scale(1.02); box-shadow: 0 8px 25px rgba(0,0,0,0.15); }

.post-footer { display: flex; gap: 35px; border-top: 1px solid #f2f2f7; padding-top: 25px; margin-top: 25px; }
.footer-item { font-size: 14px; color: #86868b; display: flex; align-items: center; gap: 10px; cursor: pointer; transition: 0.2s; }
.footer-item:hover { color: var(--apple-blue); }

/* Image Viewer */
.image-viewer { display: none; position: fixed; top: 0; left: 0; width: 100vw; height: 100vh; background: rgba(0,0,0,0.95); z-index: 9999; justify-content: center; align-items: center; }
.image-viewer.active { display: flex; }
.viewer-img { max-width: 90%; max-height: 90vh; border-radius: 12px; box-shadow: 0 20px 60px rgba(0,0,0,0.5); }
.close-viewer { position: absolute; top: 30px; right: 30px; font-size: 32px; color: #fff; cursor: pointer; width: 50px; height: 50px; background: rgba(255,255,255,0.1); backdrop-filter: blur(10px); border-radius: 50%; display: flex; justify-content: center; align-items: center; transition: 0.3s; }
.close-viewer:hover { background: rgba(255,255,255,0.2); transform: rotate(90deg); }
</style>
